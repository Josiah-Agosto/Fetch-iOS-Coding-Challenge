//
//  MealDetailView.swift
//  Fetch iOS Coding Challenge
//
//  Created by Josiah Agosto on 6/24/24.
//

import SwiftUI

struct MealDetailView: View {
    // MARK: - References / Properties
    /// ViewModel responsible for fetching and managing meal details.
    @ObservedObject var mealDetailViewModel: MealDetailViewModel
    
    var body: some View {
        GeometryReader { reader in
            ScrollView(.vertical) {
                VStack {
                    // Display meal thumbnail image if available
                    Image(uiImage: mealDetailViewModel.thumbnailImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: UIScreen.main.bounds.height / 3)
                        .clipped()
                    // Meal Details VStack
                    VStack(alignment: .leading, spacing: 20) {
                        // Display meal name and area
                        MealBasicInfoView()
                        // Display meal instructions if available
                        if let instructions = mealDetailViewModel.meal.instructions {
                            MealInstructionsView(instructions: instructions)
                        }
                        // Display meal ingredients if available
                        if let ingredientsMeasure = mealDetailViewModel.meal.ingredientsMeasure, !ingredientsMeasure.isEmpty {
                            MealIngredientsView(ingredientsMeasure: ingredientsMeasure)
                        }
                        // Display YouTube link if available
                        if let youtubeLink = mealDetailViewModel.meal.youtubeLink, let url = URL(string: youtubeLink) {
                            YoutubeLinkView(url: url)
                        }
                    }
                    .padding(.horizontal)
                    // Spacer to add extra space for scrolling
                    Spacer(minLength: 50)
                }
                .background(Color.white)
            }
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
    
    // MARK: - Subviews
    /// View displaying meal name and area.
    private func MealBasicInfoView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(mealDetailViewModel.meal.name ?? "Unknown")
                .font(.title)
                .bold()
            Text(mealDetailViewModel.meal.area ?? "Unknown Area")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    /// View displaying meal instructions.
    /// - Parameter instructions: Instructions text to display.
    private func MealInstructionsView(instructions: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Instructions")
                .font(.headline)
                .bold()
                .padding(.bottom, 5)
            Text(instructions)
                .font(.body)
        }
    }
    
    /// View displaying meal ingredients.
    /// - Parameter ingredientsMeasure: Dictionary containing ingredients and their measurements.
    private func MealIngredientsView(ingredientsMeasure: [String: String]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Ingredients")
                    .font(.headline)
                    .bold()
                Text("(\(ingredientsMeasure.count))")
                    .bold()
                    .foregroundColor(.green)
            }
            ForEach(ingredientsMeasure.sorted(by: >), id: \.key) { (key, value) in
                if !key.isEmpty && !value.isEmpty {
                    HStack {
                        Text(key)
                            .font(.headline)
                        Spacer()
                        Text(value)
                            .font(.subheadline)
                    }
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous).fill(Color.gray.opacity(0.1))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(.gray.opacity(0.2), lineWidth: 1)
                    )
                }
            }
            .padding(.top, 5)
        }
    }
    
    /// View displaying a link to a YouTube video.
    /// - Parameter url: URL of the YouTube video.
    private func YoutubeLinkView(url: URL) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("YouTube")
                .font(.headline)
                .bold()
                .padding(.bottom, 5)
            Link(destination: url) {
                Text("Watch on YouTube")
                    .font(.body)
                    .foregroundColor(.blue)
            }
        }
    }
    
}


// MARK: - Preview Provider
struct MealDetailView_PreviewProvider: PreviewProvider {
    
    static var previews: some View {
        let previewMeal = Meal(mealId: "123", name: "Apple", thumbnail: "", area: "America", category: "Dessert", instructions: "This is a long list of instructions as to how someone can do something. These instructions are a test and do nothing but are taking up space to show how long real instruction may be.", youtubeLink: "https://www.youtube.com/watch?v=dQw4w9WgXcQ", ingredientsMeasure: [
            "Apples": "3 cups sliced",
            "Sugar": "1 cup",
            "Cinnamon": "1 teaspoon",
            "Flour": "2 tablespoons",
            "Butter": "1/2 cup"
        ])
        let viewModel = MealDetailViewModel(meal: previewMeal, mealDbManager: MealDbManager())
        MealDetailView(mealDetailViewModel: viewModel)
    }
    
}
