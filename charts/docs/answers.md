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
  - `Answer`: Yes, there is a specific image ledgers-keycloak, also depends on the version of the Ledgers

12. Why do we use token token in ledgers if there is password already available for all users?
`Answer`: Token provides additional layer of security.

13. Can we obtain a token for Anton Brueckner with the help of xs2a spi level?
- `Answer`: No,  

14. You are not able to merge your branch in develop pipeline fails, What should you do?
- `Answer`: Check the logs of the failed pipeline, contact devops.

15. Is it possible to create a merge request from develop branch and set the target to support branch in xs2a? can we merge such merge request?
- `Answer`: Yes it is possible but it will cause conflicts, and it can't be merged

16. Can we launch developer portal in docker if there is no angular installed on your computer?
- `Answer`: Yes

17. Is is possible to launch xs2a with embedded ledgers application?
- `Answer`: No

18. Describe the case when rebase of a branch is required
- ref number 9 question

19. How can we get information about the ledgers users with ledgers Swagger UI?
- `Answer`: I will launch Ledgers , then check on 8888 then i will see predefined users in the swager ui
20. Can we see the password of Anton Brueckner in ledgers db?
 - `Answer`: Yes, we can but it is encrypted
21. Describe the process of local setup for Model bank launching for develop branch
- `Answer`: Download keycloak and pull postgresql docker image
- xs2a, connector, ledgers and run all them from develop
- go to dynamic sand box and run the 3 services from there
22. You have test modelbank with feature branch for xs2a. Describe  your steps to do this.
- `Answer`: switch to feature branch and check the version of the xs2a in the pom.xml, change version of xs2a in the projects tthat are depending on it
,(connector, modelbank)
23. Describle your steps for the spring version in xs2a?
- `Answer`: Visit the maven repository, look for version and changes that are related.

24.You have updated the spring version in xs2a and now integration tests are failing(spring content cannot be created) Describle steps
- `Answer`: check config classes and make sure that updated version is compactible with , revisit test configuration. clear cache and rebuild

25. How you test any java dependency for vulnerabilities?
- `Answer`: Use tools like OWASP Dependency Checker, SonarQube, etc., visit maven repo, the vulnerabilities, are always shown there

26.You try to perform sca for the payment for the postman test, PUT request gives 401 http status code, which application should you investigate and debug in this case?
- `Answer`: Connector examples

27. How can you see the balances for Anton Brueckner's account with the help of BG API? Describe all steps
- `Answer`: Create the consent for Anton Brueckner with rights 
- Then redirect it takes you to the login page
- input password and username and confirm the consent

28. You have performed a release but customer wrote a letter that he is not able to get artifacts and imagse , what are your steps?
- `Answer`: Check the artifacts if it was created during the release process, or maybe gitlab has an issue

29. Why do we require mappers in xs2a?
- `Answer`: for xs2a to work with for example ledgers, we need this mappers to map the business objects.
30. Is it possible to delete the branch in xs2a on local machine?
- `Answer`: Yes, you can delete the branch by using `git branch -d <branch_name>`, git push origin command with the -d flag
31. What is the purpose of concent in psd2?
- `Answer`: It allows users to grant access to their data, in their accounts, on their bahave.

32. How does ledgers validate qwac certificate?
- `Answer`: Ledgers does not deal with certificate validation.

33. Why do we require hotfixes?
- `Answer`: When we notice bugs in a release of a feature, and it has 3 values.

34. How can we change the version of project in all the pom.xml files?
- `Answer`: By running the release script, manually update the version in all the pom.xml files. or we can use a code

35. How does KeyCloak interacts with ledgers?
- `Answer`: Keycloak uses the keycload token enchange, it is kept inside the /provider of the keycloak

36. What is token in KeyCloak? What is a scope of the token?
- `Answer`: A token is a string that is used to authenticate a user to a system. Scope of a token is the set of permissions the token grants to the user or client.