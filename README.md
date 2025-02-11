### Summary: Include screenshots or a video of your app highlighting its features
![RecipeView](https://github.com/user-attachments/assets/27f7c929-9b92-48f2-86e9-d268b0c68874)
_init(networkService: NetworkServiceProtocol = MockNetworkService(jsonType: .success)) { }_

![Filtered - RecipeView](https://github.com/user-attachments/assets/ef33bca2-363d-412a-a515-88909302045f)
Filtered View

![Malformed-JSON-RecipeView](https://github.com/user-attachments/assets/cf5d8806-651c-4191-9a9f-bf66cae194a7)
_init(networkService: NetworkServiceProtocol = MockNetworkService(jsonType: .malformed)) { }_

![Empty-JSON-RecipeView](https://github.com/user-attachments/assets/5c0b36d4-ce01-4bfc-9988-96d7c4d1e473)
_init(networkService: NetworkServiceProtocol = MockNetworkService(jsonType: .empty)) { }_

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
I focused on NetworkService and Image Caching because they are critical to the app’s functionality. Without reliable data fetching and efficient caching, the user experience would suffer regardless of how well the UI is designed. Ensuring smooth network requests, proper error handling, and optimized image loading improves performance and keeps the app responsive.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent about five hours on this project over the weekend, following the guidelines in the iOS interview attachment sheet. My time was divided between setting up the core functionality, writing tests to ensure reliability, and refining the overall structure to keep the code clean and maintainable.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
I prioritized core functionality over UI, ensuring that the app's foundation was solid before refining its appearance. Most of my time was spent on data handling, testing, and performance optimizations, with UI design receiving the least attention.

### Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest part of the project is the lack of a keyword search for recipes, as filtering is currently limited to cuisine type, Additionally, there are no external links to sources like YouTube or a recipe’s original URL, which could enhance the user experience by providing more details or video instructions.

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
None 😊 - great take-home project!
