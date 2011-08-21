package awayphysics.collision.shapes
{
	import awayphysics.plugin.ITerrain;

	public class AWPHeightfieldTerrainShape extends AWPShape
	{
		private var dataPtr : uint;

		public function AWPHeightfieldTerrainShape(terrain : ITerrain)
		{
			var dataLen : int = terrain.sw * terrain.sh;
			dataPtr = bullet.createHeightmapDataBufferMethod(dataLen);

			var data : Vector.<Number> = terrain.heights;
			alchemyMemory.position = dataPtr;
			for (var i : int = 0; i < dataLen; i++ ) {
				alchemyMemory.writeFloat(data[i] / _scaling);
			}

			pointer = bullet.createTerrainShapeMethod(dataPtr, terrain.sw, terrain.sh, terrain.lw / _scaling, terrain.lh / _scaling, 1, -terrain.maxHeight / _scaling, terrain.maxHeight / _scaling, 1);
		}

		public function deleteHeightfieldTerrainShapeBuffer() : void
		{
			bullet.removeHeightmapDataBufferMethod(dataPtr);
		}
	}
}