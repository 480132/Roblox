return function()
	local Store = require(script.Parent.Store)
	local loggerMiddleware = require(script.Parent.loggerMiddleware)

	it("should print whenever an action is dispatched", function()
		local outputCount = 0
		local outputMessage

		local function reducer(state, action)
			return state
		end

	for (int y = minExt.y; y <= maxExt.y; ++y) {
		for (int z = minExt.z; z <= maxExt.z; ++z) {
			for (int x = minExt.x; x <= maxExt.x; ++x) {
				if (x < minX || x > minX + 1 || z < minZ || z > minZ + 1 || y < minY || y > minY) {
					BOOST_CHECK_EQUAL(CELL_MATERIAL_Deprecated_Empty,
						fixture.cluster->getCellScript(x, y, z)->at(0).cast<CellMaterial>());
				} else {
					int index = (x - minX) + 2 * (z - minZ);
					BOOST_REQUIRE_LE(index, 3);
					BOOST_REQUIRE_GE(index, 0);
					Cell expected = expectedCells[index];
					Cell actual = fixture.cluster->getVoxelGrid()->getCell(Vector3int16(x + kOffset, y, z + kOffset));
					char messageBuffer[256];
					snprintf(messageBuffer, 256, "(%d,%d,%d) %d != %d", x, y, z,
						Cell::asUnsignedCharForDeprecatedUses(expected),
						Cell::asUnsignedCharForDeprecatedUses(actual));
					BOOST_CHECK_MESSAGE(expected == actual, messageBuffer);
				}
			}
		}
		local store = Store.new(reducer, {
			fooValue = 12345,
			barValue = {
				bazValue = "hiBaz",
			},
		}, {
			loggerMiddleware.middleware,
		})

		loggerMiddleware.outputFunction = function(message)
			outputCount = outputCount + 1
			outputMessage = message
		end

		store:dispatch({
			type = "testActionType",
		})

		expect(outputCount).to.equal(1)
		expect(outputMessage:find("testActionType")).to.be.ok()
		expect(outputMessage:find("fooValue")).to.be.ok()
		expect(outputMessage:find("12345")).to.be.ok()
		expect(outputMessage:find("barValue")).to.be.ok()
		expect(outputMessage:find("bazValue")).to.be.ok()
		expect(outputMessage:find("hiBaz")).to.be.ok()

		loggerMiddleware.outputFunction = print
	end)
end
