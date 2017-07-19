require('bundler/setup')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }
also_reload('lib/**/*.rb')
require('pry')

get('/') do
  @surveys = Survey.all
  erb(:index)
end

get('/take') do
  @surveys = Survey.all
  erb(:take)
end

get('/surveys/:id') do
  @survey = Survey.find(params.fetch('id').to_i)
  erb(:survey)
end

get('/take/surveys/:id') do
  @survey = Survey.find(params.fetch('id').to_i)
  erb(:take_survey)
end

get('/surveys/:survey_id/questions/:id')do
  @survey = Survey.find(params.fetch('survey_id').to_i)
  @question = Question.find(params.fetch('id').to_i)
  erb(:question)
end

post('/surveys') do
  survey = Survey.new(name: params.fetch('name'), target_audience: params.fetch('target_audience'), id: nil)
  survey.save
  if survey.save
    redirect('/')
  else
    erb(:errors)
  end
end

post('/surveys/:survey_id/questions') do
  survey = Survey.find(params.fetch('survey_id').to_i)
  question = Question.new(name:params.fetch('name'),extras:params.fetch('extras'), survey_id: survey.id,id:nil)
  question.save
  if question.save
    redirect('/surveys/'.concat(survey.id.to_s))
  else
    erb(:errors)
  end
end

post('/take/surveys/:survey_id/answers')do
  @survey = Survey.find(params.fetch('survey_id').to_i)
  answers = params.fetch('answers')
  answers.to_s
  answers.each do |ans|
    @question = Question.find(ans[0].to_i)
    @answer = Answer.new(name:ans[1], question_id: @question.id, author: params.fetch('author'), id: nil)
    @answer.save
  end
  redirect('/take')
end
