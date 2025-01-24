## github-commit-watcher

### Description

Get notifications (WebEx webhook) about new commits been pushed into different repositories.

### Configuration

#### Set your repositories to be watched

TODO

#### Send notifications

*Option A:*

The example value of the encrypted WebEx Webhook URL is a fake one, see `\config\webex.ini` file.<br>
Please ensure you change the value to **your** encrypted WebEx Webhook URL.<br>
This can be made by `\src\utils\crypt-ex.au3` file.

*Option B:*

Use a clear WebEx Webhook URL string in the configuration file.<br>
Simply change `_B64Ex2Str($sEncryptedWebExWebhookUrl)` to `sEncryptedWebExWebhookUrl`<br>
in `\src\handler\webex-handler.au3` file.

### TODO

Redesign README.md file.
