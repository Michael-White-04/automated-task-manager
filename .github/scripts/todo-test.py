
import unittest
import sys
from todo import Task, TaskPool


class TestTaskPool(unittest.TestCase):

    def setUp(self):
        self.pool = TaskPool()

    def test_add_task(self):
        task = Task("New Task")
        self.pool.add_task(task)

        self.assertEqual(len(self.pool.tasks), 1)

    def test_get_open_tasks(self):
        self.pool.populate()

        open_tasks = self.pool.get_open_tasks()

        self.assertEqual(len(open_tasks), 3)
        self.assertTrue(
            all(task.status == "ToDo" for task in open_tasks)
        )

    def test_get_done_tasks(self):
        self.pool.populate()

        done_tasks = self.pool.get_done_tasks()

        self.assertEqual(len(done_tasks), 3)
        self.assertTrue(
            all(task.status == "Done" for task in done_tasks)
        )

    def test_mark_completed(self):
        task = Task("Complete documentation")

        task.mark_completed()

        self.assertTrue(task.completed)
        self.assertEqual(task.status, "Done")


if __name__ == "__main__":
    unittest.main(verbosity=2)
