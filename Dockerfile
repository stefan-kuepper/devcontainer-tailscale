FROM archlinux:latest


# RUN curl "https://archlinux.org/mirrorlist/?country=BE&country=DE&country=NL&protocol=https&ip_version=4&use_mirror_status=on" | sed "s/^#Server/Server/" > /etc/pacman.d/mirrorlist \
#   && pacman -Syu --noconfirm openssh sudo git fish ripgrep fd \
#   && pacman -Scc --noconfirm
RUN pacman -Syu --noconfirm openssh sudo git fish ripgrep fd helix \
  && pacman -Scc --noconfirm \
  && rm -rf /var/cache/pacman/*

RUN ssh-keygen -A


RUN useradd -m -s /usr/bin/fish stefan \
  && echo "stefan All=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/stefan


RUN mkdir /home/stefan/.ssh \
  && chmod 700 /home/stefan/.ssh

COPY ./id_ed25519.pub /home/stefan/.ssh/authorized_keys
RUN chmod 600 /home/stefan/.ssh/authorized_keys \
  && chown -R stefan:stefan /home/stefan

USER stefan:stefan


USER root

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

COPY ./scripts /scripts
CMD ["sh", "/scripts/start.sh"]
  
