Insert
export ERL_AFLAGS="-kernel shell_history enabled"
into your .bash_rc (or similar) to enable session-spanning iex command history


Windows with WSL2:
To access the Phoenix server get the WSL2 ip via `wsl hostname -I` and use that instead of localhost or setup port forwarding in the browser

ueberauth_callback for success: 
%Ueberauth.Auth{                                                                                                                                                       credentials: %Ueberauth.Auth.Credentials{                                                                                                                                                              expires: true,                                                                                                                                                                                       expires_at: 1616943300,                                                                                                                                                                              other: %{},                                                                                                                                                                                          refresh_token: nil,                                                                                                                                                                                  scopes: ["https://www.googleapis.com/auth/fitness.activity.read openid https://www.googleapis.com/auth/userinfo.email"],                                                                             secret: nil,                                                                                                                                                                                         token: "SUPERLONGTOKENSTRING",
    token_type: "Bearer"
  },
  extra: %Ueberauth.Auth.Extra{
    raw_info: %{
      token: %OAuth2.AccessToken{
        access_token: "SUPERLONGTOKENSTRING",
        expires_at: 1616943300,
        other_params: %{
          "id_token" => "SUPERSUPERLONGTOKENSTRING",
          "scope" => "https://www.googleapis.com/auth/fitness.activity.read openid https://www.googleapis.com/auth/userinfo.email"
        },
        refresh_token: nil,
        token_type: "Bearer"
      },
      user: %{
        "email" => "mobilgroma@googlemail.com",
        "email_verified" => true,
        "picture" => "https://lh6.googleusercontent.com/-5Dy87KHTF9k/AAAAAAAAAAI/AAAAAAAAAAA/9IGEEQi-B1A/photo.jpg",
        "sub" => "114909616228486575241"
      }
    }
  },
  info: %Ueberauth.Auth.Info{
      birthday: nil,
      description: nil,
      email: "mobilgroma@googlemail.com",
      first_name: nil,
      image: "https://lh6.googleusercontent.com/-5Dy87KHTF9k/AAAAAAAAAAI/AAAAAAAAAAA/9IGEEQi-B1A/photo.jpg",
      last_name: nil,
      location: nil,
      name: nil,
      nickname: nil,
      phone: nil,
      urls: %{profile: nil, website: nil}
    },
    provider: :google,
    strategy: Ueberauth.Strategy.Google,
    uid: "114909616228486575241"
}

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
