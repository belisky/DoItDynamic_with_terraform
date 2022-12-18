# DoItDynamic_with_terraform
In this project I apply the concept of Infrastructure as Code(IaC) using terraform to provision resources in AWS Cloud. The End Results are just amazing!!!


## Infrastructure Diagram
![alt text](https://github.com/belisky/DoItDynamic_with_terraform/blob/main/Load%20Balancer.png?raw=true)

## Resources Provisioned
- VPC
- Subnets (Both public and private)
- Internet Gateway
- Target Groups
- Load Balancer
- EC2 instances with docker installed
- Route Tables

### Commands executed
- terraform init
- terraform apply


## Appendix.
Sample image of load balancer distributing request to different instances in the target group.
![alt text](https://github.com/belisky/DoItDynamic_with_terraform/blob/main/Screenshot%20from%202022-12-16%2012-24-01.png?raw=true)

 

### Sample image of load balancer distributing incoming request.
_**Nb: Changed host name.**_
![alt text](https://github.com/belisky/DoItDynamic_with_terraform/blob/main/Screenshot%20from%202022-12-16%2012-24-41.png?raw=true)

