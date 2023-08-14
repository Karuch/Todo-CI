# Simple To-Do List Application

This is a simple web application that allows users to manage tasks on a to-do list. It also exposes a REST API for programmatic access, as well as metrics via a `/metrics` endpoint.


## Configuration

To configure the application, adjust the following environemnt variables:

| Variable name     | Default value                | Description                                                                                                     |
|-------------------|------------------------------|-----------------------------------------------------------------------------------------------------------------|
| `DEBUG_ENABLED`   | "false"                      | If the Flask server should be started in Debug mode.                                                            |
| `LOG_LEVEL`       | "INFO"                       | The desired logging level (DEBUG, INFO, WARNING, ERROR, or CRITICAL).                                           |
| `MONGO_URI`       | "mongodb://localhost:27017/" | The URI of your MongoDB database.                                                                               |
| `METRICS_ENABLED` | "true"                       | If metrics should be registered (note that the `/metrics` route still will exist, just won't contain any data). |


## Usage

### Web UI

The web UI provides a simple interface for managing tasks on the to-do list. You can add tasks by typing them into the input box and clicking "Add Task" and delete tasks by clicking the "Delete" button next to the task you want to remove.

### REST API

The REST API provides programmatic access to the to-do list, and adds the additional functionality of editing existing tasks. You can interact with it using standard HTTP methods (`GET`, `POST`, `PUT`):

- To retrieve a list of all tasks, make a `GET` request to `/api`.
- To add a task, make a `POST` request to `/api/add` with the task in the form data.
- To delete a task, make a `POST` request to `/api/delete`.
- To edit a task, make a `PUT` request to `/api/edit` with both the old & new and tasks in the form data.

Example API test call (with `curl`):

```bash
curl -X PUT localhost:5000/api/edit -d "old_task=make cake&new_task=chop salad"
```


## Metrics

The application exposes metrics via the `/metrics` endpoint. If metrics are enabled (`METRICS_ENABLED=true`), you can access them by visiting http://localhost:5000/metrics in your web browser.

The following metrics are available:

| Metric name      | Type    | Description                                           |
|------------------|---------|-------------------------------------------------------|
| `index_requests` | Counter | Count of requests to index.html page.                 |
| `tasks_count`    | Guage   | Number of tasks in the database.                      |
| `tasks_added`    | Counter | Count of tasks added since the application started.   |
| `tasks_edited`   | Counter | Count of tasks edited since the application started.  |
| `tasks_deleted`  | Counter | Count of tasks deleted since the application started. |
