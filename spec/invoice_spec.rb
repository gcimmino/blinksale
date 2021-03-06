require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

collection_xml = File.read(File.expand_path(File.dirname(__FILE__) + "/fixtures/invoice_collection.xml"))

describe Blinksale::Invoice do
  describe ".from_node" do
    let(:node) do
      Nokogiri::XML(collection_xml).xpath("//xmlns:invoice").first
    end

    it "returns Invoice instance" do
      Blinksale::Invoice.from_node(node).should be_an_instance_of(Blinksale::Invoice)
    end

    describe "invoice" do
      let(:invoice) do
        Blinksale::Invoice.from_node(node)
      end

      it "has proper attributes set" do
        invoice.id.should eql(1)
        invoice.number.should eql("100001")
        invoice.total_amount.should eql(20.0)
        invoice.due_amount.should eql(10.0)
        invoice.issued_on.should eql(Date.new(2006, 9, 19))
        invoice.due_on.should eql(Date.new(2006, 10, 4))
        invoice.currency.should eql("USD")
      end
    end
  end
end
