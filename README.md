# MV2Switch

## Manifest V2 Availability Setter for Chromium Browsers

MV2Switch provides a graphical user interface (GUI) to set the ExtensionManifestV2Availability registry key for Chromium-based browsers (Google Chrome, Microsoft Edge, Brave, etc). The script allows you to control the availability of Manifest V2 extensions by modifying the registry key, which affects the extension behavior in these browsers.
### Browsers currently supported
- **Google Chrome**
- **Microsoft Edge**
- **Brave** (Already supports it, just to be sure)

### Features:
- **1. Default browser behavior**
- **2. Disable Manifest V2 Extensions**
- **3. Enable Manifest V2 Extensions**
- **4. Manifest V2 is enabled for forced extensions only**

---

# How to Run
### Run the command below in PowerShell:

```ps1
iwr "https://raw.githubusercontent.com/ltx0101/MV2Switch/main/MV2Switch.ps1" -OutFile "MV2Switch.ps1"; .\MV2Switch.ps1
```
<details>
<summary> Requirements </summary>

- Windows 10/11
- PowerShell with Administrator privileges
</details>

<details>
<summary>Error "Running Scripts is Disabled on this System"</summary>

### Run this command in PowerShell:

```ps1
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```
</details>

---
<div align="center">
   
[![PayPal Donate](https://img.shields.io/badge/PayPal_Donate-s?style=for-the-badge&logo=paypal&logoColor=black)](https://paypal.me/AggelosMeta)

</div>

<div align="center">
  
Made with ❤️ and PowerShell  

</div>
