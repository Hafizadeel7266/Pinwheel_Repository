# Pinwheel Connection Commands

**1. Connect to Redshift through EC2 (default pem key)**  
_Used to create an SSH tunnel from local machine to Redshift via EC2 instance using default pv_key.pem._  
```bash
ssh -i  ~/.ssh/pv_key.pem -L 5439:redshift-cluster-1.cowm94akwkjx.us-east-2.redshift.amazonaws.com:5439 ec2-user@3.141.191.185
```

**2. SSH directly to EC2 server (Waleed user)**  
_Used to log in directly to the EC2 server as user 'waleed'._  
```bash
ssh -i /home/waleed/.ssh/pv_key.pem waleed@3.141.191.185
```

**3. Connect to Redshift through EC2 (Waleed pem key)**  
_Similar to command 1 but uses a pem key located in Waleed's home directory._  
```bash
ssh -i /home/waleed/.ssh/pv_key.pem -L 5439:redshift-cluster-1.cowm94akwkjx.us-east-2.redshift.amazonaws.com:5439 waleed@3.141.191.185
```

**4. Connect to Redshift using psql**  
_Used to connect to the Redshift database locally after setting up the SSH tunnel._  
```bash
psql -h localhost -p 5439 -U waleed -d dev -W
```

**5. Connect via alternate EC2 server using dbt key**  
_Creates SSH tunnel to Redshift via a different EC2 server using the id_rsa_aws_redshift_dbt key._  
```bash
ssh -i ./id_rsa_aws_redshift_dbt -L 5439:redshift-cluster-1.cowm94akwkjx.us-east-2.redshift.amazonaws.com:5439 waleed@154.57.217.196
```

**6. Alternate port mapping for Redshift tunnel**  
_Uses a different local port (15439) to connect to Redshift in case default 5439 is in use._  
```bash
ssh -L 15439:redshift-cluster-1.cowm94akwkjx.us-east-2.redshift.amazonaws.com:5439 -i ./id_rsa_aws_redshift_dbt waleed@3.141.191.185
```

<!-- Press Ctrl+Shift+V -->
