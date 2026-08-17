# Development accounts all use password123. The seeds are intentionally
# idempotent so `bin/rails db:seed` can be run repeatedly.
seed_users = [
  {
    name: "Alex Morgan", email: "demo@carebridge.test", date_of_birth: Date.new(1990, 5, 14), gender: "Non-binary",
    conditions: [
      ["Seasonal allergies", "Sneezing, itchy eyes, and a runny nose", Date.new(2025, 4, 8), false, "Managing seasonal allergies"],
      ["Migraine", "Throbbing headache, nausea, and light sensitivity", Date.new(2024, 11, 20), false, "Migraine check-in"]
    ]
  },
  {
    name: "Jordan Lee", email: "jordan.lee@carebridge.test", date_of_birth: Date.new(1985, 2, 18), gender: "Female",
    conditions: [
      ["Type 2 diabetes", "Increased thirst and fluctuating blood glucose", Date.new(2022, 6, 12), false, "Blood glucose routine"],
      ["Hypertension", "Usually no symptoms; occasional headaches", Date.new(2023, 9, 3), false, "Blood pressure follow-up"]
    ]
  },
  {
    name: "Samir Patel", email: "samir.patel@carebridge.test", date_of_birth: Date.new(1978, 10, 29), gender: "Male",
    conditions: [
      ["Asthma", "Wheezing and shortness of breath during exercise", Date.new(2019, 3, 16), false, "Asthma action plan"],
      ["Eczema", "Dry, itchy patches on hands and elbows", Date.new(2024, 1, 25), false, "Eczema skin care"]
    ]
  },
  {
    name: "Priya Shah", email: "priya.shah@carebridge.test", date_of_birth: Date.new(1994, 7, 7), gender: "Female",
    conditions: [
      ["Iron deficiency anemia", "Fatigue, dizziness, and pale skin", Date.new(2025, 2, 6), false, "Improving iron levels"],
      ["Generalized anxiety", "Persistent worry and trouble sleeping", Date.new(2023, 5, 19), false, "Anxiety check-in"]
    ]
  },
  {
    name: "Marcus Reed", email: "marcus.reed@carebridge.test", date_of_birth: Date.new(1968, 12, 2), gender: "Male",
    conditions: [
      ["Osteoarthritis", "Knee stiffness and pain after activity", Date.new(2021, 8, 30), false, "Knee mobility plan"],
      ["High cholesterol", "No noticeable symptoms", Date.new(2020, 4, 14), false, "Cholesterol review"]
    ]
  },
  {
    name: "Elena Garcia", email: "elena.garcia@carebridge.test", date_of_birth: Date.new(1989, 4, 22), gender: "Female",
    conditions: [
      ["Hypothyroidism", "Tiredness, feeling cold, and dry skin", Date.new(2022, 11, 9), false, "Thyroid medication check"],
      ["Vitamin D deficiency", "Low energy and muscle aches", Date.new(2025, 1, 11), false, "Vitamin D progress"]
    ]
  },
  {
    name: "Noah Williams", email: "noah.williams@carebridge.test", date_of_birth: Date.new(2001, 9, 15), gender: "Male",
    conditions: [
      ["Acne", "Inflamed spots on face and back", Date.new(2024, 6, 5), false, "Acne treatment routine"],
      ["Sprained ankle", "Pain and swelling after a sports injury", Date.new(2025, 7, 21), true, "Returning to activity"]
    ]
  },
  {
    name: "Aisha Khan", email: "aisha.khan@carebridge.test", date_of_birth: Date.new(1997, 1, 31), gender: "Female",
    conditions: [
      ["Irritable bowel syndrome", "Abdominal discomfort and changes in bowel habits", Date.new(2023, 10, 8), false, "IBS food diary"],
      ["Lactose intolerance", "Bloating after dairy products", Date.new(2020, 2, 17), false, "Dairy alternatives"]
    ]
  },
  {
    name: "Theo Andersen", email: "theo.andersen@carebridge.test", date_of_birth: Date.new(1973, 6, 24), gender: "Male",
    conditions: [
      ["Sleep apnea", "Loud snoring and daytime sleepiness", Date.new(2021, 12, 1), false, "Better sleep habits"],
      ["Gastroesophageal reflux", "Heartburn after meals", Date.new(2024, 3, 13), false, "Managing reflux"]
    ]
  },
  {
    name: "Maya Chen", email: "maya.chen@carebridge.test", date_of_birth: Date.new(1982, 8, 9), gender: "Female",
    conditions: [
      ["Psoriasis", "Scaly, itchy skin patches", Date.new(2020, 7, 27), false, "Psoriasis flare tracking"],
      ["Tension headache", "Dull pressure around the forehead and neck", Date.new(2025, 5, 4), false, "Reducing tension headaches"]
    ]
  }
]

seed_users.each do |attributes|
  user = User.find_or_initialize_by(email: attributes[:email])
  user.assign_attributes(attributes.except(:conditions).merge(password: "password123", password_confirmation: "password123"))
  user.save!

  attributes[:conditions].each do |description, symptoms, diagnosed_on, cured, chat_title|
    condition = Condition.find_or_create_by!(description: description, symptoms: symptoms, diagnosed_on: diagnosed_on) do |record|
      record.cured = cured
    end

    Chat.find_or_create_by!(user: user, condition: condition, title: chat_title)
  end
end
