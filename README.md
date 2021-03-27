Insert
export ERL_AFLAGS="-kernel shell_history enabled"
into your .bash_rc (or similar) to enable session-spanning iex command history


Windows with WSL2:
To access the Phoenix server get the WSL2 ip via `wsl hostname -I` and use that instead of localhost or setup port forwarding in the browser



Google Fit API Request example:
URL: https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate
Request Body:
{
  "aggregateBy": [{
    "dataTypeName": "com.google.step_count.delta",
    "dataSourceId": "derived:com.google.step_count.delta:com.google.android.gms:estimated_steps"
  }],
  "bucketByTime": { "durationMillis": 86400000 },
  "startTimeMillis": 1616194800000,
  "endTimeMillis": 1616713200000
}

Result Example:
{
  "bucket": [
    {"startTimeMillis": "1616281200000", 
      "endTimeMillis": "1616367600000", 
      "dataset": [
        {
          "dataSourceId": "derived:com.google.step_count.delta:com.google.android.gms:aggregated", 
          "point": [
            {
              "startTimeNanos": "1616339220000000000", 
              "originDataSourceId": "raw:com.google.step_count.delta:fitapp.fittofit:FitToFit - step count", 
              "endTimeNanos": "1616341620000000000", 
              "value": [
                {
                  "mapVal": [], 
                  "intVal": 4772
                }
              ], 
              "dataTypeName": "com.google.step_count.delta"
            }
          ]
        }
      ]
    }
]}
