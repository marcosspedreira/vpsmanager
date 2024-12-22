#!/bin/bash

# Verificar permissões de root
if [[ $EUID -ne 0 ]]; then
    echo -e "\033[1;31mEste script deve ser executado como root.\033[0m"
    exit 1
fi

# Banner de Boas-vindas
clear
for i in {1..3}; do
    clear
    echo -e "\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo -e "\033[1;36m             ⇱ BEM-VINDO AO ANONYNET MANAGER ⇲               \033[0m"
    echo -e "\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
    echo ""
    echo -e "    \033[1;31mATENÇÃO: ESTE SCRIPT IRÁ CONFIGURAR FERRAMENTAS\n   PARA GERENCIAMENTO DE REDE E SISTEMA.\033[0m"
    echo ""
    echo -e "\033[1;32mDICA: USE O TEMA DARK NO TERMINAL PARA UMA MELHOR EXPERIÊNCIA!\033[0m"
    echo ""
    sleep 0.5
done

# Confirmar início da instalação
echo -ne "\033[1;32mPressione ENTER para continuar a instalação: \033[0m"; read x

# Atualizar pacotes do sistema
echo -e "\033[1;32mAtualizando pacotes do sistema...\033[0m"
apt-get update -y
apt-get upgrade -y

# Instalar pacotes essenciais
echo -e "\033[1;32mInstalando pacotes essenciais...\033[0m"
apt install -y curl wget nano figlet lolcat python3 python3-pip jq git socat uuid-runtime

# Configurar Firewall
echo -e "\033[1;32mConfigurando portas do firewall...\033[0m"
firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=8080/tcp
firewall-cmd --reload

# Baixar e configurar o V2Ray Manager
echo -e "\033[1;32mBaixando e configurando o V2Ray Manager...\033[0m"
cd /usr/local/bin/
rm -f v2raymanager
wget -O v2raymanager https://raw.githubusercontent.com/modderajuda/donomodderajuda/main/M/v2raymanager
chmod +x v2raymanager
ln -sf /usr/local/bin/v2raymanager /usr/bin/v2raymanager

# Adicionar menu principal no login do terminal
echo -e "\033[1;32mConfigurando o terminal...\033[0m"
cat > /root/.bashrc <<-EOF
clear
echo -e "\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;36m             ⇱ BEM-VINDO AO ANONYNET ⇲               \033[0m"
echo -e "\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;33mPara gerenciar o servidor, digite:\033[1;36m v2raymanager\033[0m"
echo -e "\033[1;32m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
EOF

# Recarregar todos os serviços usando bibliotecas desatualizadas
echo -e "\033[1;32mRecarregando serviços com bibliotecas atualizadas...\033[0m"
if command -v needrestart >/dev/null 2>&1; then
    needrestart -r a >/dev/null 2>&1
else
    apt install -y needrestart
    needrestart -r a >/dev/null 2>&1
fi

# Finalização
clear
echo -e "\033[1;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;32m       INSTALAÇÃO CONCLUÍDA COM SUCESSO!             \033[0m"
echo -e "\033[1;37m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;33mPara iniciar o menu de gerenciamento, digite: \033[1;36mv2raymanager\033[0m"
history -c && echo > ~/.bash_history