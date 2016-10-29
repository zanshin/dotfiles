template "__name__" do
  source "__source__"
  owner "__owner__"
  group "__group__"
  mode "__mode__"
  variables({
    __variable__: __setting__
  })
  action :create
end
