-- Features:
-- Open the currently selected line in the remote repository
-- Copy the URL of the remote repository for the currently selected line
-- Open the line currently selected in blame mode in the remote repository
-- Open pull request the last changed commit
return {
    "ksaito422/remote-line.nvim",
    cmd = "RemoteLine",
    opts = {}
}