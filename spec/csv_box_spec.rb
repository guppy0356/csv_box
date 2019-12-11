RSpec.describe CSVBox do
  before do
    CSVBox.add 'book' do
      field 'id'
      field 'title'
      field 'price'
    end

    CSVBox.layouts 'book' do
      layout 'shuffled layout' do |box|
        box.price
        box.id
        box.title
      end
    end
  end

  let(:books) do
    [
      double(id: 1, title: 'How to cook delicious meals', price: 1500),
      double(id: 2, title: '10 tips to lose weight', price: 250)
    ]
  end
  
  describe '.box_names' do
    example 'get box names' do
      expect(CSVBox.box_names).to match(['book'])
    end
  end

  describe '.take' do
    example 'print csv with shuffled layout' do
      box = CSVBox.take 'book', 'shuffled layout'

      books.each do |book|
        box << book
      end

      expect(box.to_csv).to eq(<<~CSV)
        price,id,title
        1500,1,How to cook delicious meals
        250,2,10 tips to lose weight
      CSV
    end
  end
end
