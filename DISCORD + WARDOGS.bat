@echo off
set "BIN=%~dp0bin\"
cd /d "%BIN%"
"%BIN%winws.exe" --wf-tcp=80,443 --wf-udp=443,4192,19294-19344,50000-50100 ^
--filter-tcp=443 --hostlist-domains=discord.com,discord.gg,discordapp.com --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls="%BIN%stun.bin" --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-fake-discord="%BIN%ACTIVE_DISCORD_UDP.bin" --dpi-desync-fake-stun="%BIN%ACTIVE_DISCORD_UDP.bin" --dpi-desync-repeats=6 --new ^
--filter-tcp=80,443 --hostlist-domains=wardogs.com,bulkhead.com,team17.com,live.wardogs.bulkhead.pragmaengine.com,firstlook.gg,api.epicgames.dev --hostlist-exclude-domains=elytra.ac --dpi-desync=fake,fakedsplit --dpi-desync-repeats=6 --dpi-desync-fooling=ts --dpi-desync-fakedsplit-pattern=0x00 --dpi-desync-fake-tls="%BIN%stun.bin" --dpi-desync-fake-tls="%BIN%tls_clienthello_www_google_com.bin" --dpi-desync-fake-http="%BIN%tls_clienthello_max_ru.bin" --new ^
--filter-udp=443 --hostlist-domains=wardogs.com,bulkhead.com,team17.com,live.wardogs.bulkhead.pragmaengine.com,firstlook.gg,api.epicgames.dev --hostlist-exclude-domains=elytra.ac --dpi-desync=fake --dpi-desync-repeats=11 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=4192 --dpi-desync=fake --dpi-desync-repeats=10 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%ACTIVE_GAME_UDP.bin" --dpi-desync-cutoff=n2
pause
