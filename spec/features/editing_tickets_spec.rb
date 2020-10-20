require "rails_helper"

RSpec.feature "Users can edit existing tickets" do
  let(:author)  { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project) }
  let(:ticket) do
    FactoryBot.create(:ticket, project: project, author: author)
  end

  before do
    visit project_ticket_path(project, ticket)
    click_link "Edit Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Make it really shiny!"
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has been updated."

    within(".ticket h2") do
      expect(page).to have_content "Make it really shiny!"
      expect(page).not_to have_content ticket.name
    end
  end

  scenario "with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has not been updated."
  end

  scenario "with multiple attachments", js: true do
    attach_file("spec/fixtures/spin.txt", class: 'dz-hidden-input', visible: false)
    expect(page).to have_content "spin.txt"

    click_button "Update Ticket"

    expect(page).to have_content "Ticket has been updated."

    within(".ticket .attachments") do
      expect(page).to have_content "spin.txt"
    end
  end

  context "when the ticket has tags" do
    before do
      ticket.tags << FactoryBot.create(:tag, name: "Visual Testing")
      ticket.tags << FactoryBot.create(:tag, name: "Browser")

      visit project_ticket_path(project, ticket)
    end

    it "sees existing tags on edit form" do
      click_link "Edit Ticket"

      within('.tags') do
        expect(page).to have_content("Visual Testing")
        expect(page).to have_content("Browser")
      end
    end

    it "can add new tags to a ticket" do
      click_link "Edit Ticket"
      fill_in "Tags", with: "regression, bug"
      click_button "Update Ticket"
      expect(page).to have_content("Ticket has been updated.")

      within(".ticket .attributes .tags") do
        expect(page).to have_content("Visual Testing")
        expect(page).to have_content("Browser")
        expect(page).to have_content("regression")
        expect(page).to have_content("bug")
      end
    end
  end
end
