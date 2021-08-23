-- Honest node 2

\connect honest_node_2

set session_replication_role to replica;

update public.job_specs set id = uuid_in('34a4f869633641d79ecc50b76999b9de') where id = 'a025abb21d29439fb40b07a3bf61692d';

update public.initiators set job_spec_id = uuid_in('34a4f869633641d79ecc50b76999b9de') where job_spec_id = 'a025abb21d29439fb40b07a3bf61692d';

update public.task_specs set job_spec_id = uuid_in('34a4f869633641d79ecc50b76999b9de') where job_spec_id = 'a025abb21d29439fb40b07a3bf61692d';

update public.job_runs set job_spec_id = uuid_in('34a4f869633641d79ecc50b76999b9de') where job_spec_id = 'a025abb21d29439fb40b07a3bf61692d';

set session_replication_role to default;



-- Honest node 3

\connect honest_node_3

set session_replication_role to replica;

update public.job_specs set id = uuid_in('34a4f869633641d79ecc50b76999b9de') where id = '5eddc8c1661841ea9e430e2426aa3e3a';

update public.initiators set job_spec_id = uuid_in('34a4f869633641d79ecc50b76999b9de') where job_spec_id = '5eddc8c1661841ea9e430e2426aa3e3a';

update public.task_specs set job_spec_id = uuid_in('34a4f869633641d79ecc50b76999b9de') where job_spec_id = '5eddc8c1661841ea9e430e2426aa3e3a';

update public.job_runs set job_spec_id = uuid_in('34a4f869633641d79ecc50b76999b9de') where job_spec_id = '5eddc8c1661841ea9e430e2426aa3e3a';

set session_replication_role to default;



-- Bad node 1

\connect bad_node_1

set session_replication_role to replica;

update public.job_specs set id = uuid_in('34a4f869633641d79ecc50b76999b9de') where id = '792a58069d414dbe91c6ea1844db498c';

update public.initiators set job_spec_id = uuid_in('34a4f869633641d79ecc50b76999b9de') where job_spec_id = '792a58069d414dbe91c6ea1844db498c';

update public.task_specs set job_spec_id = uuid_in('34a4f869633641d79ecc50b76999b9de') where job_spec_id = '792a58069d414dbe91c6ea1844db498c';

update public.job_runs set job_spec_id = uuid_in('34a4f869633641d79ecc50b76999b9de') where job_spec_id = '792a58069d414dbe91c6ea1844db498c';

set session_replication_role to default;
