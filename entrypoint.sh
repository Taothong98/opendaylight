#!/bin/bash
# Start SSH server as the root user
/usr/sbin/sshd -D &
# Wait for SSH server to start (you can customize the sleep duration as needed)
sleep 5

if [ -n "$FEATURES" ]; then
    # Update the featuresBoot line in org.apache.karaf.features.cfg
    su - user -c "sed -i \"s/\(featuresBoot= \|featuresBoot = \)/featuresBoot = $FEATURES,/g\" /home/user/karaf-${KARAF_VERSION}/etc/org.apache.karaf.features.cfg"
fi
chmod +w /home/user/karaf-${KARAF_VERSION}/etc/
# Run Karaf as the non-root user
su - user -c "/home/user/karaf-${KARAF_VERSION}/bin/karaf run"
# Keep the container running
tail -f /dev/null