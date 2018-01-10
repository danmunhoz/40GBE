TUTORIAL PARA SIMULAÇAO DE TESTES

1 - Definir o caminho do projeto no script:
    config.py

2 - Configurar os cenários no script:
    config.py

3 - No diretório testes executar permissão nos scripts:
    chmod 755 script.sh
    chmod 755 cleaner.sh
    chmod 755 load_dump.sh

4 - Executar o script script.sh para iniciar as simulações
    ./script.sh

5 - *Se os cenários não estiverem com os arquivos de entrada dump_mii_tx.txt
    ou se as configurações forem alteradas, executar o script load_dump.sh
    antes do script.sh
    ./load_dump.sh
