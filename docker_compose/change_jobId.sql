-- Honest node 2

\connect honest_node_2

set session_replication_role to replica;

update public.job_specs set id = uuid_in('99528cade2084ad7a177b93446450e6a') where id = 'b55018d5c8ca4683b613ec0b39968e59';

update public.initiators set job_spec_id = uuid_in('99528cade2084ad7a177b93446450e6a') where job_spec_id = 'b55018d5c8ca4683b613ec0b39968e59';

update public.task_specs set job_spec_id = uuid_in('99528cade2084ad7a177b93446450e6a') where job_spec_id = 'b55018d5c8ca4683b613ec0b39968e59';

update public.job_runs set job_spec_id = uuid_in('99528cade2084ad7a177b93446450e6a') where job_spec_id = 'b55018d5c8ca4683b613ec0b39968e59';

set session_replication_role to default;



-- Honest node 3

\connect honest_node_3

set session_replication_role to replica;

update public.job_specs set id = uuid_in('99528cade2084ad7a177b93446450e6a') where id = '5f6026473ead439a8c9e2ecbb2c93c5f';

update public.initiators set job_spec_id = uuid_in('99528cade2084ad7a177b93446450e6a') where job_spec_id = '5f6026473ead439a8c9e2ecbb2c93c5f';

update public.task_specs set job_spec_id = uuid_in('99528cade2084ad7a177b93446450e6a') where job_spec_id = '5f6026473ead439a8c9e2ecbb2c93c5f';

update public.job_runs set job_spec_id = uuid_in('99528cade2084ad7a177b93446450e6a') where job_spec_id = '5f6026473ead439a8c9e2ecbb2c93c5f';

set session_replication_role to default;



-- Bad node 1

\connect bad_node_1

set session_replication_role to replica;

update public.job_specs set id = uuid_in('99528cade2084ad7a177b93446450e6a') where id = '356d7d29325b4f6c897263a5f4ec84a6';

update public.initiators set job_spec_id = uuid_in('99528cade2084ad7a177b93446450e6a') where job_spec_id = '356d7d29325b4f6c897263a5f4ec84a6';

update public.task_specs set job_spec_id = uuid_in('99528cade2084ad7a177b93446450e6a') where job_spec_id = '356d7d29325b4f6c897263a5f4ec84a6';

update public.job_runs set job_spec_id = uuid_in('99528cade2084ad7a177b93446450e6a') where job_spec_id = '356d7d29325b4f6c897263a5f4ec84a6';

set session_replication_role to default;
