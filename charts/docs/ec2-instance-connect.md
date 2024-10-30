### [EC2 instance connect](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/connect-linux-inst-eic.html)

### [Labs for bigginers](https://aws.amazon.com/getting-started/hands-on/?awsf.getting-started-category=category%23compute&awsf.getting-started-content-type=content-type%23hands-on&getting-started-all.sort-by=item.additionalFields.content-latest-publish-date&getting-started-all.sort-order=desc)
- EC2 Instance Connect is a secure alternative to SSH for connecting to Amazon EC2 instances.
- It provides a web-based SSH connection that eliminates the need to manage SSH keys.
- With EC2 Instance Connect, you can connect to your instances using IAM roles and temporary security credentials.
- This feature is available for instances running Amazon Linux 2, Ubuntu, and Amazon Linux.
- To use EC2 Instance Connect, you must have the necessary IAM permissions and the AWS CLI or AWS SDK installed on your local machine.

**Command to update EC2 system**
```bash
sudo yum update -y
```

**IP Ranges
**Brief notes on IP Ranges when dealing with EC2 Instance Connect:**
- EC2 Instance Connect uses the following IP ranges for outbound connections:
  - `169.254.169.253/32` (Amazon DNS)
  - `169.254.169.123/32` (NTP)
  - `169.254.169.127/32` (EC2 Instance Metadata Service)
- Make sure your security group rules allow outbound traffic to these IP ranges.
- If you have a custom VPC, ensure that the VPC's route table has a route to the internet gateway.
- If you have a NAT gateway, ensure that the NAT gateway's route table has a route to the internet gateway.

```json
{
"syncToken": "1730131989",
"createDate": "2024-10-28-16-13-09",
"prefixes": [
{
"ip_prefix": "3.4.12.4/32",
"region": "eu-west-1",
"service": "AMAZON",
"network_border_group": "eu-west-1"
},
{
"ip_prefix": "3.5.140.0/22",
"region": "ap-northeast-2",
"service": "AMAZON",
"network_border_group": "ap-northeast-2"
},
{
"ip_prefix": "15.190.244.0/22",
"region": "ap-east-2",
"service": "AMAZON",
"network_border_group": "ap-east-2"
},
{
"ip_prefix": "15.230.15.29/32",
"region": "eu-central-1",
"service": "AMAZON",
"network_border_group": "eu-central-1"
},
{
"ip_prefix": "15.230.15.76/31",
"region": "eu-central-1",
"service": "AMAZON",
"network_border_group": "eu-central-1"
}
]
}
```
**Brief notes on Inbound and Outbound Traffic and also Security Group and Rules:**
- Inbound traffic refers to data entering an EC2 instance.
- Outbound traffic refers to data leaving an EC2 instance.
- By default, all inbound traffic is blocked, and all outbound traffic is allowed.
- You can control inbound traffic using security group rules.
- You can control outbound traffic using network ACL rules.
- A security group acts as a virtual firewall for your EC2 instances.
- It controls inbound traffic to your instances based on predefined rules.
- You can create security groups and define inbound rules to allow or deny traffic to your instances.
- Security groups are stateful, meaning that traffic that is allowed inbound is automatically allowed outbound in response.
- You can also use security group rules to reference other security groups, allowing you to create complex network configurations.


#### Example Configuration for EC2 Instance Connect, Security Groups, and IP Ranges:
In this example, we will create a security group for an EC2 instance, configure inbound rules, and ensure that outbound traffic is allowed to the necessary IP ranges.

**Step 1: Create a Security Group**
- Open the Amazon EC2 console.
- Navigate to the "Security Groups" page.
- Click on "Create security group."
- Give your security group a name (e.g., "EC2-Instance-Connect-SG") and a description.
- Click on "Create."

**Step 2: Configure Inbound Rules**
- Once the security group is created, click on its name to open its details.
- In the "Inbound rules" tab, click on "Edit inbound rules."
- Click on "Add rule."
- Select "SSH" as the type.
- Set the source to "Anywhere" or specify the IP address range that you want to allow SSH access from.
- Click on "Save."

**Step 3: Configure Outbound Rules**
- In the "Outbound rules" tab, click on "Edit outbound rules."
- Click on "Add rule."
- Select "All traffic" as the type.
- Set the destination to "Custom IP" and specify the necessary IP ranges for outbound traffic, including the EC2 Instance Connect IP ranges.
- Click on "Save."

**Step 4: Attach the Security Group to the EC2 Instance**
- Navigate to the "Instances" page in the Amazon EC2 console.
- Select the EC2 instance that you want to associate with the security group.
- Click on "Actions," then "Security," and finally "Change security groups."
- Select the security group you created (e.g., "EC2-Instance-Connect-SG") and click on "Assign security groups."

**Step 5: Connect to the EC2 Instance using EC2 Instance Connect**
- In the "Instances" page, select the EC2 instance.
- Click on "Connect" and follow the instructions to connect to the instance using EC2 Instance Connect.

**Step 6: Verify Outbound Traffic**
- Once connected to the EC2 instance, you can use tools like curl or telnet to verify that outbound traffic is allowed to the necessary IP ranges.

**Example Configuration (JSON):**
```json
{
  "SecurityGroups": [
    {
      "GroupName": "EC2-Instance-Connect-SG",
      "Description": "Security group for EC2 Instance Connect",
      "IpPermissions": [
        {
          "IpProtocol": "tcp",
          "FromPort": 22,
          "ToPort": 22,
          "IpRanges": [
            {
              "CidrIp": "0.0.0.0/0"
            }
          ],
          "Ipv6Ranges": []
        }
      ],
      "IpPermissionsEgress": [
        {
          "IpProtocol": "-1",
          "IpRanges": [
            {
              "CidrIp": "169.254.169.253/32"
            },
            {
              "CidrIp": "169.254.169.123/32"
            },
            {
              "CidrIp": "169.254.169.127/32"
            },
            {
              "CidrIp": "3.4.12.4/32"
            },
            {
              "CidrIp": "3.5.140.0/22"
            },
            {
              "CidrIp": "15.190.244.0/22"
            },
            {
              "CidrIp": "15.230.15.29/32"
            },
            {
              "CidrIp": "15.230.15.76/31"
            },
            {
              "CidrIp": "0.0.0.0/0"
            }
          ],
          "Ipv6Ranges": [],
          "PrefixListIds": [],
          "UserIdGroupPairs": []
        }
      ],
      "Tags": [],
      "VpcId": "vpc-0123456789abcdef0"
    }
  ]
}
```