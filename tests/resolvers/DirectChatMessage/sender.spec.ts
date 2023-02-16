import "dotenv/config";
import { sender as senderResolver } from "../../../src/resolvers/DirectChatMessage/sender";
import { connect, disconnect } from "../../../src/db";
import { User } from "../../../src/models";
import { beforeAll, afterAll, describe, it, expect } from "vitest";
import {
  createTestDirectChatMessage,
  TestDirectChatMessageType,
} from "../../helpers/directChat";

let testDirectChatMessage: TestDirectChatMessageType;
beforeAll(async () => {
  await connect();
  const temp = await createTestDirectChatMessage();
  testDirectChatMessage = temp[3];
});

afterAll(async () => {
  await disconnect();
});

describe("resolvers -> DirectChatMessage -> sender", () => {
  it(`returns user object for parent.sender`, async () => {
    const parent = testDirectChatMessage!.toObject();

    const senderPayload = await senderResolver?.(parent, {}, {});

    const sender = await User.findOne({
      _id: testDirectChatMessage!.sender,
    }).lean();

    expect(senderPayload).toEqual(sender);
  });
});