TUTORIAL PARA SIMULAÇAO DE TESTES

1 - Definir o caminho do projeto nos scripts:
    move_tx.py
    move_mii_tx.py
    move_output.py

2 - No diretório testes executar permissão nos scripts:
    chmod 755 script.sh
    chmod 755 cleaner.sh
    chmod 755 load_dump.sh

3 - Executar o script script.sh para iniciar as simulações
    ./script.sh

4 - *Se os cenários não estiverem com os arquivos de entrada dump_mii_tx.txt
    executar o script load_dump.sh antes do script.sh
    ./load_dump.sh
