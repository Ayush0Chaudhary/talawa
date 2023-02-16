import { QueryResolvers } from "../../types/generatedGraphQLTypes";
import { errors } from "../../libraries";
import { DirectChatMessage } from "../../models";
import {
  CHAT_NOT_FOUND,
  CHAT_NOT_FOUND_CODE,
  CHAT_NOT_FOUND_PARAM,
} from "../../constants";

export const directChatsMessagesByChatID: QueryResolvers["directChatsMessagesByChatID"] =
  async (_parent, args) => {
    const directChatsMessages = await DirectChatMessage.find({
      directChatMessageBelongsTo: args.id,
    }).lean();

    if (directChatsMessages.length === 0) {
      throw new errors.NotFoundError(
        CHAT_NOT_FOUND,
        CHAT_NOT_FOUND_CODE,
        CHAT_NOT_FOUND_PARAM
      );
    }

    return directChatsMessages;
  };