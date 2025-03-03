# Website Monitor 

Um script simples para **monitoramento de estado de websites** com notificações pelo Discord.  
Este script monitora a saúde de websites e envia **notificações automáticas** para um canal de Discord sempre que o estado de um site muda.

## Funcionalidades

- **Monitoramento de Websites:** O script verifica se o site está acessível, utilizando requisições HTTP HEAD.
- **Notificações no Discord:** Toda vez que o estado de um site muda de estado o script envia uma notificação para um canal do Discord.
- **Armazenamento Local:** O estado e dados dos sites monitorados são armazenados em um arquivo de texto, com informações como URL, apelido, último estado e data/hora da última checagem bem-sucedida.

### Tipos de Erro Detectados
- **Erros HTTP** (ex: 404, 500) e **Timeouts** são monitorados através dos códigos de saída 22 e 28 do cUrl respectivamente.
- Outros tipos de erro (instabilidades de rede, etc.) são ignorados, evitando falsos positivos.

## Como Usar

### 1. Configuração Inicial

Para rodar o script, siga as etapas abaixo:

1. **Prepare o arquivo de dados:** O script precisa de um arquivo de texto com informações dos websites chamado `monitor-db`, que deve estar no mesmo diretório. Um arquivo de exemplo `monitor-db.sample` é fornecido, contendo informações sobre sites da UnB.
2. **Configuração do Discord:** Defina a variável de ambiente `HOOK_URL` com a URL do webhook do canal de Discord onde as notificações serão enviadas.
3. **Permissões de Execução:** Garanta que o script tenha permissões de execução:

```bash
$ chmod u+x ./website-monitor
```

4. **Execute o script:** Garanta que o script tenha permissões de execução:

```bash
$ ./website-monitor
```

## 2. Monitoramento contínuo

Para rodar o script de forma contínua, você pode configurar o script para rodar periodicamente.
Com exemplos abaixo para ```cron``` e ```systemd```.

### Usando Cron
Configure o cron através de ```crontab -e``` para rodar o script periodicamente. Exemplo para rodar a cada 5 minutos:

```bash
*/5 * * * * cd /caminho/para/website-monitor/; ./website-monitor
```

Para armazenar a saída em um arquivo de log com data/hora (data/hora fornecida pelo comando ts do pacote ```moreutils```):

```bash
*/5 * * * * cd /caminho/para/website-monitor/; ./website-monitor | ts > /var/log/website-monitor.log
```

### Usando SystemD

Você também pode configurar um serviço systemd para rodar o script automaticamente. Aqui estão os exemplos de configuração:

#### website-monitor.service
```ini
[Unit]
Description=Monitorar e notificar estado de websites
After=network.target

[Service]
Type=oneshot
WorkingDirectory=/caminho/para/website-monitor
ExecStart=/caminho/para/website-monitor/website-monitor
OnBootSec=10s
```

#### website-monitor.timer
```ini
[Unit]
Description=Rodar monitorador a cada 2 minutos

[Timer]
OnBootSec=2m
OnUnitActiveSec=2m

[Install]
WantedBy=timers.target
```

## Exemplo de Saída 
Quando o script detectar uma mudança de estado, ele envia uma notificação para o Discord, como estas:

<pre>⌛ SITE está apresentando lentidão! 
❌ SITE está fora do ar! 😞  
✅ SITE está online!
</pre>
