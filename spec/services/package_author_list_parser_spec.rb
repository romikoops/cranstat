require 'rails_helper'

RSpec.describe PackageAuthorListParser do
  describe '#call' do
    context 'when data present' do
      let(:parser) { described_class.new(data: data) }
      context 'when emails present in author field' do
        let(:data) do
          {
            'Author' => 'Karline Soetaert <karline.soetaert@nioz.nl>'
          }
        end
        it { expect(parser.call).to eq([{ 'name' => 'Karline Soetaert', 'email' => 'karline.soetaert@nioz.nl' }]) }
      end
      context 'when emails missing in author field' do
        context 'when emails present in authors@R field' do
          let(:data) do
            {
              'Author' => 'Julio Trecenti [aut], Athos Damiani [ctb], Fernando Correa [aut, cre], ' \
                          'Brazillian Jurimetrics Association [cph]',
              'Authors@R' => 'c( person("Julio", "Trecenti", role = "aut", ' \
                             'email = "jtrecenti@abj.org.br"), person("Athos", "Damiani", ' \
                             'role = "ctb", email = "athos.damiani@gmail.com"), ' \
                             'person("Fernando", "Correa", role = c("aut","cre"), ' \
                             'email = "fcorrea@abj.org.br"), person(family = "Brazillian Jurimetrics Association", ' \
                             'role = "cph"))'
            }
          end
          it do
            expect(parser.call).to eq([
                                        { 'name' => 'Julio Trecenti', 'email' => 'jtrecenti@abj.org.br' },
                                        { 'name' => 'Athos Damiani', 'email' => 'athos.damiani@gmail.com' },
                                        { 'name' => 'Fernando Correa', 'email' => 'fcorrea@abj.org.br' },
                                        { 'name' => 'Brazillian Jurimetrics Association' }
                                      ])
          end
        end
        context 'when authors@R field blank' do
          let(:data) do
            {
              'Author' => 'Jean-Michel Marin [aut, cre], Louis Raynal [aut], ' \
                          'Pierre Pudlo [aut], Christian P. Robert [ctb], Arnaud Estoup [ctb]'
            }
          end
          it do
            expect(parser.call).to eq([
                                        { 'name' => 'Jean-Michel Marin' },
                                        { 'name' => 'Louis Raynal' },
                                        { 'name' => 'Pierre Pudlo' },
                                        { 'name' => 'Christian P. Robert' },
                                        { 'name' => 'Arnaud Estoup' }
                                      ])
          end
        end
      end
    end
    context 'when data blank' do
      let(:parser) { described_class.new }
      it { expect(parser.call).to eq([]) }
    end
  end
end
