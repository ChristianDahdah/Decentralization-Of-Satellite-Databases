// SPDX-License-Identifier: MIT
pragma solidity ^0.6.6;

import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";
import "@chainlink/contracts/src/v0.6/SignedSafeMath.sol";

library Median {
  using SignedSafeMath for uint32;

  uint32 constant UINT32_MAX = 2**32-1;

  /**
   * @notice See documentation for function calculate.
   * @dev The list passed as an argument may be permuted.
   */
  function calculateInplace(uint32[] memory list)
    internal
    pure
    returns (uint32)
  {
    require(0 < list.length, "list must not be empty");
    uint32 len = uint32(list.length);
    uint32 middleIndex = len / 2;
    if (len % 2 == 0) {
      uint32 median1;
      uint32 median2;
      (median1, median2) = quickselectTwo(list, 0, len - 1, middleIndex - 1, middleIndex);
      return uint32(SignedSafeMath.avg(median1, median2));
    } else {
      return quickselect(list, 0, len - 1, middleIndex);
    }
  }

  /**
   * @notice Maximum length of list that shortSelectTwo can handle
   */
  uint32 constant SHORTSELECTTWO_MAX_LENGTH = 7;

  /**
   * @notice Select the k1-th and k2-th element from list of length at most 7
   * @dev Uses an optimal sorting network
   */
  function shortSelectTwo(
    uint32[] memory list,
    uint32 lo,
    uint32 hi,
    uint32 k1,
    uint32 k2
  )
    private
    pure
    returns (uint32 k1th, uint32 k2th)
  {
    // Uses an optimal sorting network (https://en.wikipedia.org/wiki/Sorting_network)
    // for lists of length 7. Network layout is taken from
    // http://jgamble.ripco.net/cgi-bin/nw.cgi?inputs=7&algorithm=hibbard&output=svg

    uint32 len = hi + 1 - lo;
    uint32 x0 = list[lo + 0];
    uint32 x1 = 1 < len ? list[lo + 1] : UINT32_MAX;
    uint32 x2 = 2 < len ? list[lo + 2] : UINT32_MAX;
    uint32 x3 = 3 < len ? list[lo + 3] : UINT32_MAX;
    uint32 x4 = 4 < len ? list[lo + 4] : UINT32_MAX;
    uint32 x5 = 5 < len ? list[lo + 5] : UINT32_MAX;
    uint32 x6 = 6 < len ? list[lo + 6] : UINT32_MAX;

    if (x0 > x1) {(x0, x1) = (x1, x0);}
    if (x2 > x3) {(x2, x3) = (x3, x2);}
    if (x4 > x5) {(x4, x5) = (x5, x4);}
    if (x0 > x2) {(x0, x2) = (x2, x0);}
    if (x1 > x3) {(x1, x3) = (x3, x1);}
    if (x4 > x6) {(x4, x6) = (x6, x4);}
    if (x1 > x2) {(x1, x2) = (x2, x1);}
    if (x5 > x6) {(x5, x6) = (x6, x5);}
    if (x0 > x4) {(x0, x4) = (x4, x0);}
    if (x1 > x5) {(x1, x5) = (x5, x1);}
    if (x2 > x6) {(x2, x6) = (x6, x2);}
    if (x1 > x4) {(x1, x4) = (x4, x1);}
    if (x3 > x6) {(x3, x6) = (x6, x3);}
    if (x2 > x4) {(x2, x4) = (x4, x2);}
    if (x3 > x5) {(x3, x5) = (x5, x3);}
    if (x3 > x4) {(x3, x4) = (x4, x3);}

    uint32 index1 = k1 - lo;
    if (index1 == 0) {k1th = x0;}
    else if (index1 == 1) {k1th = x1;}
    else if (index1 == 2) {k1th = x2;}
    else if (index1 == 3) {k1th = x3;}
    else if (index1 == 4) {k1th = x4;}
    else if (index1 == 5) {k1th = x5;}
    else if (index1 == 6) {k1th = x6;}
    else {revert("k1 out of bounds");}

    uint32 index2 = k2 - lo;
    if (k1 == k2) {return (k1th, k1th);}
    else if (index2 == 0) {return (k1th, x0);}
    else if (index2 == 1) {return (k1th, x1);}
    else if (index2 == 2) {return (k1th, x2);}
    else if (index2 == 3) {return (k1th, x3);}
    else if (index2 == 4) {return (k1th, x4);}
    else if (index2 == 5) {return (k1th, x5);}
    else if (index2 == 6) {return (k1th, x6);}
    else {revert("k2 out of bounds");}
  }

  /**
   * @notice Selects the k-th ranked element from list, looking only at indices between lo and hi
   * (inclusive). Modifies list in-place.
   */
  function quickselect(uint32[] memory list, uint32 lo, uint32 hi, uint32 k)
    private
    pure
    returns (uint32 kth)
  {
    require(lo <= k);
    require(k <= hi);
    while (lo < hi) {
      if (hi - lo < SHORTSELECTTWO_MAX_LENGTH) {
        uint32 ignore;
        (kth, ignore) = shortSelectTwo(list, lo, hi, k, k);
        return kth;
      }
      uint32 pivotIndex = partition(list, lo, hi);
      if (k <= pivotIndex) {
        // since pivotIndex < (original hi passed to partition),
        // termination is guaranteed in this case
        hi = pivotIndex;
      } else {
        // since (original lo passed to partition) <= pivotIndex,
        // termination is guaranteed in this case
        lo = pivotIndex + 1;
      }
    }
    return list[lo];
  }

  /**
   * @notice Selects the k1-th and k2-th ranked elements from list, looking only at indices between
   * lo and hi (inclusive). Modifies list in-place.
   */
  function quickselectTwo(
    uint32[] memory list,
    uint32 lo,
    uint32 hi,
    uint32 k1,
    uint32 k2
  )
    internal // for testing
    pure
    returns (uint32 k1th, uint32 k2th)
  {
    require(k1 < k2);
    require(lo <= k1 && k1 <= hi);
    require(lo <= k2 && k2 <= hi);

    while (true) {
      if (hi - lo < SHORTSELECTTWO_MAX_LENGTH) {
        return shortSelectTwo(list, lo, hi, k1, k2);
      }
      uint32 pivotIdx = partition(list, lo, hi);
      if (k2 <= pivotIdx) {
        hi = pivotIdx;
      } else if (pivotIdx < k1) {
        lo = pivotIdx + 1;
      } else {
        assert(k1 <= pivotIdx && pivotIdx < k2);
        k1th = quickselect(list, lo, pivotIdx, k1);
        k2th = quickselect(list, pivotIdx + 1, hi, k2);
        return (k1th, k2th);
      }
    }
  }

  /**
   * @notice Partitions list in-place using Hoare's partitioning scheme.
   * Only elements of list between indices lo and hi (inclusive) will be modified.
   * Returns an index i, such that:
   * - lo <= i < hi
   * - forall j in [lo, i]. list[j] <= list[i]
   * - forall j in [i, hi]. list[i] <= list[j]
   */
  function partition(uint32[] memory list, uint32 lo, uint32 hi)
    private
    pure
    returns (uint32)
  {
    // We don't care about overflow of the addition, because it would require a list
    // larger than any feasible computer's memory.
    uint32 pivot = list[(lo + hi) / 2];
    lo -= 1; // this can underflow. that's intentional.
    hi += 1;
    while (true) {
      do {
        lo += 1;
      } while (list[lo] < pivot);
      do {
        hi -= 1;
      } while (list[hi] > pivot);
      if (lo < hi) {
        (list[lo], list[hi]) = (list[hi], list[lo]);
      } else {
        // Let orig_lo and orig_hi be the original values of lo and hi passed to partition.
        // Then, hi < orig_hi, because hi decreases *strictly* monotonically
        // in each loop iteration and
        // - either list[orig_hi] > pivot, in which case the first loop iteration
        //   will achieve hi < orig_hi;
        // - or list[orig_hi] <= pivot, in which case at least two loop iterations are
        //   needed:
        //   - lo will have to stop at least once in the interval
        //     [orig_lo, (orig_lo + orig_hi)/2]
        //   - (orig_lo + orig_hi)/2 < orig_hi
        return hi;
      }
    }
  }

  /**
   * @notice Makes an in-memory copy of the array passed in
   * @param list Reference to the array to be copied
   */
  function copy(uint32[] memory list)
    private
    pure
    returns(uint32[] memory)
  {
    uint32[] memory list2 = new uint32[](list.length);
    for (uint32 i = 0; i < list.length; i++) {
      list2[i] = list[i];
    }
    return list2;
  }
}
