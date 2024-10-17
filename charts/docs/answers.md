1.
- Difference between ledgers and cms db
 - ledgers store the information concerning the account, account like the bank database
 - cms db stores the information about the concent of the users

2. urls and rest controllers used in the spi level
 - spi layer is the set of classes responsible to map information(business objects) from xs2a to connector examples
 - `Urls and rest controllers used`: There are no rest controllers, it is just and interface to transfer context data(`information about the psu and tpp`) between xs2a and connector

3. Explain if our xs2a solution can be installed in a real bank in and if yes, then how?
  - `Answer:` No, it can not be installed in a real bank, 
   - why xs2a solution is tied to connector example , each bank has its own connector example 

4. Can we use model bank application without connector examples? why?
 - `Answer:` No, if its our model bank, we can't Because Model bank depends on connector example, which it uses it as a library

5. How can we debug SPI level?
- `Answer:` We can debug it in the connector example, by putting breakpoints on the interfaces that are responsible for the bugs

6. Describe the payment initiation flow in Modelbank.
- `Answer:` we have two approaches(embedded and redirect)
 - `Redirect Approach`
   - initiate payment
   - Get payment status
   - Get payment information
   - Delete payment data
 - `Embedded Approach`
   - initiate payment
   - Start authorization process

7 . What is a pipeline in gitlab?
 - `Answer:` Compile instructions, on how to deploy our application, it consists of stages, like test, compile, deploy..... found in a gitlab-ci.yaml file

8. How can we increase the balance for Anton Bruckner with admin access to CMS? Do we require password for Anton Brueckner to do this?
- `Answer`: No, 

9. Describe the branching rebasing flow in git, When do we require rebasing?
- `Answer:` Rebasing is a way to integrate changes from one branch into another.
   - It moves or combines a sequence of commits from one branch onto another. done with `git rebase <branch>`
   `Why`: Rebasing is useful when you want to integrate changes from one branch into another and maintain a clean commit history.
   - `Answer:` Rebasing is commonly used when you want to update your feature branch with the latest changes from the main branch before merging.

10. Can we test QWAC accessor without connector?
 - `Answer`: Yes, We don't need a connector to test the QWAC, we have qwac as a library, as proxy and as a standalone
 - only possible if we want to test QWAC as a library

11. Can we launch Ledgers with KeyCloak in Docker? Which image is required for this?
  - `Answer`: Yes, there is a specific images keycloak, also depends on the version of the Ledgers

12. 