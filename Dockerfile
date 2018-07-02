FROM sstarcher/sensu:0.26.5 

# Enable Embedded Ruby
RUN sed -i -r 's/EMBEDDED_RUBY=false/EMBEDDED_RUBY=true/' /etc/default/sensu

# Install Mailer
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-mailer

# Install slack
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-slack

# Install Docker plugin
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-docker

# Install journald plugin
RUN /opt/sensu/embedded/bin/gem install sensu-plugins-logs && cp /opt/sensu/embedded/bin/check-journal.rb /etc/sensu/plugins/basic/check-journal.rb


# Bake config & checks in
COPY resources/conf.d/* /etc/sensu/conf.d/
COPY resources/check.d/ /etc/sensu/check.d/
COPY resources/handlers/* /etc/sensu/handlers/
COPY resources/plugins /etc/sensu/plugins/
RUN chmod -R +x /etc/sensu/plugins
