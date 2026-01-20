# Learnings

## Bash vs sh 

1. sh is the POSIX standard; Bash is a "dialect" of sh
2. Bash has more "features", but is not valid POSIX shell due to all the extensions (hence may have errors)
3. Can add Bash shebang, but have to set permissions if running without specifying shell
4. Some commands are better for scripting due to standards across system (ps -eo), others are better for humans due to readability (ps aux)