# Synchronous Identity Check

This section lists all endpoints that must be implemented for a synchronous
identity check integration.

## Get Check Config

```python
from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/")
def get_integration_metadata():
    return jsonify({
        "check_type": "IDENTITY_CHECK",
        "check_template": {
            "type": "ONE_TIME_SYNCHRONOUS",
            "timeout": 60
        },
        "pricing": {
            "supports_reselling": True,
            "maximum_cost": 200
        },
        "supported_countries": ["GBR", "USA", "CAN"],
        "credentials": {
            "fields": [
               {
                   "type": "string",
                   "name": "username",
                   "label": "Username"
               },
               {
                   "type": "password",
                   "name": "password",
                   "label": "Password"
               }
            ]
        },
        "config": {
            "fields": [
                {
                    "type": "boolean",
                    "name": "require_dob",
                    "label": "Date of birth is required for 1+1 and 2+2 results",
                    "subtext": "The individual's date of birth must be matched in one source for 1+1 and 2+2 results to be achieved",
                    "default": False
                }
            ]
        }
    })
```

This implemented