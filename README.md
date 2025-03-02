# Website Monitor

Um script simples para monitoramento de estado de websites e notificação pelo discord.

Esse script envia uma notificação em um canal de discord para cada mudança no estado do site, 
tal estado é armazenado em um arquivo de texto. Tal arquivo de texto é onde estão armazenadas as
informações do sites: URL, apelido, último estado, data e hora da última checagem bem sucedida

O script utiliza requisições HTTP HEAD para checagem e identifica apenas erros HTTP 
e timeouts (códigos de saída 22 e 28 do cUrl respecitvamente) como indicadores, com outros erros sendo ignorados,  
assim evitando que instabilidades de rede possam causar falsos positivos.

## Instruções
Para rodar o script é necessário um arquivo de texto com o nome ```monitor-db``` presente no mesmo diretório
do script, o repositório fornece um arquivo de exemplo com dois websites utilizados por estudantes da UnB 
```monitor-db.sample```. 

Além disso é necessária a variável de ambiente HOOK_URL, que deve indiciar URL de webhook do canal do discord 
a serem mandadas as notificações.

Finalmente a configuração dos sites a serem monitorados, é necessário se certificar que o 
script tem permissões de execução para o usuário atual  (```$ chmod u+x ./website-montior```) 
e rodar o script pelo terminal.

```$ ./website-monitor```

### Monitoramento contínuo

Para o monitoramento contínuo dos sites escolhidos é possível criar um serviço via systemD 
para distribuições que o utilizam, ou tarefas cron.

Para tarefas cron é necessário mudar o diretório de trabalho para que o script funcione corretamente,
para rodar o script a cada 5 minutos por exemplo:

```*/5 * * * * cd /caminho/para/website-monitor/; ./website-monitor```

Para armazenar as saídas em um arquivo de registro é possível redirecionar a saída padrão para o arquivo 
de registro. (exemplificado aqui com o comando ts que prefixa a saída com uma marca de data e hora)

```*/5 * * * * cd /caminho/para/website-monitor/; ./website-monitor | ts > /var/log/website-monitor.log```

Além disso, também pode-se criar um serviço e temporizador que serão utilizados pelo systemD, como no
exemplo abaixo:

website-monitor.service
```
[Unit]
Description=Monitorar e notificar estado de websites
After=network.target

[Service]
Type=oneshot
WorkingDirectory=/caminho/para/website-monitor
ExecStart=/caminho/para/website-monitor/website-monitor
OnBootSec=10s
```

website-monitor.timer
```
[Unit]
Description=Run website monitor script every so often

[Timer]
OnBootSec=2m
OnUnitActiveSec=2m

[Install]
WantedBy=timers.target
```

