# frozen_string_literal: true

RSpec.describe LogAnalyzer::Repositories::Domains do
  let(:instance) { described_class.new }

  describe '#add' do
    subject { instance.add(domain_name, ip) }

    let(:domain_name) { 'domain/' }
    let(:ip) { '111.222.333.444' }

    context 'when new domain' do
      it 'stores new domain' do
        expect(instance).to_not have_key('domain/')
        subject
        expect(instance).to have_key('domain/')
      end
    end

    context 'when domain already in repository' do
      before do
        instance[domain_name] = [ip]
      end

      it "doesn't save new instance only entry" do
        expect(instance).to have_key('domain/')
        expect(instance['domain/']).to eq([ip])
        subject
        expect(instance).to have_key('domain/')
        expect(instance['domain/']).to eq([ip, ip])
      end
    end
  end
end
