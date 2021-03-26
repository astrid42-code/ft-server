# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    start.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: asgaulti@student.42.fr <asgaulti>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/03/26 09:37:36 by asgaulti@st       #+#    #+#              #
#    Updated: 2021/03/26 09:37:37 by asgaulti@st      ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#sur Debian, un service (ou daemon / demon) est un script d'initialisation de type "system V" qui va permettre de gerer un service

# install ou upgrade php/ nginx/ mysql

service php7.3-fpm start
service nginx start
service mysql start

#pour maintenir le container une fois lance

while true;
        do sleep 10000;
done

# ou
# tail -f fichier de logs nginx
# nginx -g 'daemon off'