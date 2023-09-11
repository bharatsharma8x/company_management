require 'rails_helper'

RSpec.describe Department, type: :model do
  it "is valid with a name" do
    department = Department.new(department_name: "HR")
    expect(department).to be_valid
  end

  it "is invalid without a name" do
    department = Department.new(department_name: nil)
    expect(department).not_to be_valid
  end

  it "can be saved" do
    department = Department.create(department_name: "IT")
    expect(department.persisted?).to be true
  end

  it "can be updated" do
    department = Department.create(department_name: "Marketing")
    department.update(department_name: "Sales")
    expect(department.reload.department_name).to eq("Sales")
  end

  it "can be deleted" do
    department = Department.create(department_name: "Finance")
    department.destroy
    expect(Department.find_by(department_name: "Finance")).to be_nil
  end
end
