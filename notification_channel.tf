resource "newrelic_alert_channel" "kubernetes_email_alert_channel" {
  count = ((var.alert_channel_email_config != null) ? 1 : 0)
  name  = var.alert_channel_email_config.recipients
  type  = "email"

  config {
    recipients = ((var.alert_channel_email_config != null) ? var.alert_channel_email_config.recipients : null)
  }
}

resource "newrelic_alert_channel" "kubernetes_webhook_alert_channel" {
  count = ((var.alert_channel_webhook_config != null) ? 1 : 0)
  name  = "${var.cluster_name} kubernetes_webhook_alert_channel"
  type  = "webhook"

  config {
    base_url = ((var.alert_channel_webhook_config != null) ? var.alert_channel_webhook_config.base_url : null)
    payload_type = "application/json"
    payload_string = <<EOF
{
  "cards": [
    {
      "sections": [
        {
          "widgets": [
            {
              "keyValue": {
                "topLabel": "NEW RELIC $EVENT_TYPE $INCIDENT_ID",
                "content": "$SEVERITY - $EVENT_STATE",
                "onClick": {
                  "openLink": {
                    "url": "$INCIDENT_URL"
                  }
                }
              }
            }
          ]
        },
        {
          "widgets": [
            {
              "keyValue": {
                "content": "$CONDITION_NAME",
                "topLabel": "Condition"
              }
            },
            {
              "keyValue": {
                "content": "$POLICY_NAME",
                "topLabel": "Policy"
              }
            },
            {
              "keyValue": {
                "content": "$EVENT_DETAILS",
                "topLabel": "Details",
                "contentMultiline": "true"
              }
            }
          ]
        },
        {
          "widgets": [
            {
              "buttons": [
                {
                  "textButton": {
                    "text": "View $EVENT_TYPE",
                    "onClick": {
                      "openLink": {
                        "url": "$INCIDENT_URL"
                      }
                    }
                  }
                },
                {
                  "textButton": {
                    "text": "Ack $EVENT_TYPE",
                    "onClick": {
                      "openLink": {
                        "url": "$INCIDENT_ACKNOWLEDGE_URL"
                      }
                    }
                  }
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
EOF
  }
}
