module Roadmap

  def get_checkpoint(checkpoint_id)
    # checkpoint number that worked for me was 2265
    id = checkpoint_id

    response = self.class.get('https://www.bloc.io/api/v1/checkpoints/' + id.to_s, @headers)

    @checkpoint = response.parsed_response

  end

  def get_roadmap(roadmaps_id)
    # roadmap number that works for this is 38
    id = roadmaps_id

    response = self.class.get('https://www.bloc.io/api/v1/roadmaps/' + id.to_s, @headers)

    @roadmap = response.parsed_response
  end
end
