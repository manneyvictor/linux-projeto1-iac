#!/bin/bash
# Scrpit



listGroups="GRP_ADM GRP_VEN GRP_SEC"
listDir="/publico /adm /ven /sec"
listUsers="carlos maria joao debora sebastiana roberto josefina amanda rogerio"

echo -e "Checking if project directories exists..."
for dir in $listDir
    do 
        if [ -d $dir ]
        then
            echo -e "Directory '$dir' exists!\n"
        else
            echo -e "Directory not exists...\n Creating dir: $dir"
            mkdir $dir
        fi
    done

echo -e "Checking if Groups exists..."

for groups in $listGroups
    do
        if [[ $(getent group $groups) == "" ]]
        then
        echo -e "Group not exists. \nCreating group: $groups"
        groupadd $groups
        else
            echo -e "Group $groups exists!\n"
        fi
    done



echo -e "Checking if Users exists..."

for users in $listUsers
    do 
        if [[ $(getent passwd $users) == "" ]]
        then
            echo -e "User not exists. \nCreating User $users"
            if [ $users == carlos -o $users == maria -o $users == joao ]
                then useradd $users -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_ADM
            elif [ $users == debora -o $users == sebastiana -o $users == roberto ]
                then useradd $users -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_VEN
            elif [ $users == josefina -o $users == amanda -o $users == rogerio ]
                then useradd $users -m -s /bin/bash -p $(openssl passwd -crypt Senha123) -G GRP_SEC
            fi
        else
            echo -e "User $users exists!\n"
        fi
    done


echo "Directory permissioning...\n\n"
chown root:GRP_ADM /adm && chmod 770 /adm
chown root:GRP_VEN /ven && chmod 770 /ven
chown root:GRP_SEC /sec && chmod 770 /sec

echo -e "FIM!\n"