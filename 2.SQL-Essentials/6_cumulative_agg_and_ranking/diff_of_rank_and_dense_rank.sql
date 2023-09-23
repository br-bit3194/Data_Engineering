CREATE TABLE student_scores(
	student_id INT PRIMARY KEY,
	student_score INT
);

INSERT INTO student_scores VALUES
(1, 980),
(2, 960),
(3, 960),
(4, 990),
(5, 920),
(6, 960),
(7, 980),
(8, 960),
(9, 940),
(10, 940);


select * from student_scores;

-- difference of rank() and dense_rank()
select *,
	RANK() over (order by student_score desc) as rnk,
	DENSE_RANK() over (order by student_score desc) as drnk
from student_scores
order by student_score desc;
