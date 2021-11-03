class SearchesController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @method = params["method"]
    @records = search_for(@model, @content, @method)
  end

  private
  def search_for(model, content, method)
    if model == 'user'
      if method == 'perfect'
        User.where(name: content)
      elsif method == 'back'
        User.where('name LIKE ?', '%'+content)
      elsif method == 'start'
        User.where('name LIKE ?', content+'%')
      elsif method == 'partial'
        User.where('name LIKE ?', '%'+content+'%')
      end

    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      elsif method == 'back'
        Book.where('title LIKE ?', '%'+content)
      elsif method == 'start'
        Book.where('title LIKE ?', content+'%')
      elsif method == 'partial'
        Book.where('title LIKE ?', '%'+content+'%')
      end
    end
  end
end
