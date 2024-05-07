// ---- FNV Hash 87986db177f40e2

// ---- Created with 3Dmigoto v1.3.16 on Sat Nov  4 12:47:20 2023

cbuffer misc_globals : register(b2)
{
  float4 globalFade : packoffset(c0);
  float globalHeightScale : packoffset(c1);
  float globalShaderQuality : packoffset(c1.y);
  float globalReuseMe00001 : packoffset(c1.z);
  float globalReuseMe00002 : packoffset(c1.w);
  float4 POMFlags : packoffset(c2);
  float4 g_Rage_Tessellation_CameraPosition : packoffset(c3);
  float4 g_Rage_Tessellation_CameraZAxis : packoffset(c4);
  float4 g_Rage_Tessellation_ScreenSpaceErrorParams : packoffset(c5);
  float4 g_Rage_Tessellation_LinearScale : packoffset(c6);
  float4 g_Rage_Tessellation_Frustum[4] : packoffset(c7);
  float4 g_Rage_Tessellation_Epsilons : packoffset(c11);
  float4 globalScalars : packoffset(c12);
  float4 globalScalars2 : packoffset(c13);
  float4 globalScalars3 : packoffset(c14);
  float4 globalScreenSize : packoffset(c15);
  uint4 gTargetAAParams : packoffset(c16);
  float4 colorize : packoffset(c17);
  float4 gGlobalParticleShadowBias : packoffset(c18);
  float gGlobalParticleDofAlphaScale : packoffset(c19);
  float gGlobalFogIntensity : packoffset(c19.y);
  float4 gPlayerLFootPos : packoffset(c20);
  float4 gPlayerRFootPos : packoffset(c21);
}

cbuffer lighting_globals : register(b3)
{
  float4 gDirectionalLight : packoffset(c0);
  float4 gDirectionalColour : packoffset(c1);
  int gNumForwardLights : packoffset(c2);
  float4 gLightPositionAndInvDistSqr[8] : packoffset(c3);
  float4 gLightDirectionAndFalloffExponent[8] : packoffset(c11);
  float4 gLightColourAndCapsuleExtent[8] : packoffset(c19);
  float gLightConeScale[8] : packoffset(c27);
  float gLightConeOffset[8] : packoffset(c35);
  float4 gLightNaturalAmbient0 : packoffset(c43);
  float4 gLightNaturalAmbient1 : packoffset(c44);
  float4 gLightArtificialIntAmbient0 : packoffset(c45);
  float4 gLightArtificialIntAmbient1 : packoffset(c46);
  float4 gLightArtificialExtAmbient0 : packoffset(c47);
  float4 gLightArtificialExtAmbient1 : packoffset(c48);
  float4 gDirectionalAmbientColour : packoffset(c49);
  float4 globalFogParams[5] : packoffset(c50);
  float4 globalFogColor : packoffset(c55);
  float4 globalFogColorE : packoffset(c56);
  float4 globalFogColorN : packoffset(c57);
  float4 globalFogColorMoon : packoffset(c58);
  float4 gReflectionTweaks : packoffset(c59);
}

cbuffer more_stuff : register(b5)
{
  float4 gEntitySelectColor[2] : packoffset(c0);
  float4 gAmbientOcclusionEffect : packoffset(c2);
  float4 gDynamicBakesAndWetness : packoffset(c3);
  float4 gAlphaRefVec0 : packoffset(c4);
  float4 gAlphaRefVec1 : packoffset(c5);
  float gAlphaTestRef : packoffset(c6);
  bool gTreesUseDiscard : packoffset(c6.y);
  float gReflectionMipCount : packoffset(c6.z);
  float gTransparencyAASamples : packoffset(c6.w);
  bool gUseFogRay : packoffset(c7);
}

cbuffer terrain_cb_common_locals : register(b12)
{
  float specularFalloffMult : packoffset(c0);
  float specularFalloffMultSpecMap : packoffset(c0.y);
  float specFalloffAdjust : packoffset(c0.z);
  float specularIntensityMult : packoffset(c0.w);
  float specularIntensityMultSpecMap : packoffset(c1);
  float specIntensityAdjust : packoffset(c1.y);
  float bumpiness : packoffset(c1.z);
  float parallaxSelfShadowAmount : packoffset(c1.w);
  float heightScale0 : packoffset(c2);
  float heightBias0 : packoffset(c2.y);
  float heightScale1 : packoffset(c2.z);
  float heightBias1 : packoffset(c2.w);
  float heightScale2 : packoffset(c3);
  float heightBias2 : packoffset(c3.y);
  float heightScale3 : packoffset(c3.z);
  float heightBias3 : packoffset(c3.w);
  float bumpSelfShadowAmount : packoffset(c4);
  float4 materialWetnessMultiplier : packoffset(c5);
}

cbuffer rage_matrices : register(b1)
{
  row_major float4x4 gWorld : packoffset(c0);
  row_major float4x4 gWorldView : packoffset(c4);
  row_major float4x4 gWorldViewProj : packoffset(c8);
  row_major float4x4 gViewInverse : packoffset(c12);
  row_major float4x4 gWorldViewProjUnjittered : packoffset(c16);
  row_major float4x4 gWorldViewProjUnjitteredPrev : packoffset(c20);
}

SamplerState TextureSampler_layer0_s : register(s2);
SamplerState BumpSampler_layer0_s : register(s3);
SamplerState heightMapSamplerLayer0_s : register(s4);
SamplerState TextureSampler_layer1_s : register(s5);
SamplerState BumpSampler_layer1_s : register(s6);
SamplerState heightMapSamplerLayer1_s : register(s7);
SamplerState TextureSampler_layer2_s : register(s8);
SamplerState BumpSampler_layer2_s : register(s9);
SamplerState heightMapSamplerLayer2_s : register(s10);
SamplerState TextureSampler_layer3_s : register(s11);
SamplerState BumpSampler_layer3_s : register(s12);
SamplerState heightMapSamplerLayer3_s : register(s13);
Texture2D<float4> TextureSampler_layer0 : register(t2);
Texture2D<float4> BumpSampler_layer0 : register(t3);
Texture2D<float4> heightMapSamplerLayer0 : register(t4);
Texture2D<float4> TextureSampler_layer1 : register(t5);
Texture2D<float4> BumpSampler_layer1 : register(t6);
Texture2D<float4> heightMapSamplerLayer1 : register(t7);
Texture2D<float4> TextureSampler_layer2 : register(t8);
Texture2D<float4> BumpSampler_layer2 : register(t9);
Texture2D<float4> heightMapSamplerLayer2 : register(t10);
Texture2D<float4> TextureSampler_layer3 : register(t11);
Texture2D<float4> BumpSampler_layer3 : register(t12);
Texture2D<float4> heightMapSamplerLayer3 : register(t13);


// 3Dmigoto declarations
#define cmp -


void main(
  float4 v0 : SV_Position0,
  float3 v1 : TEXCOORD0,
  float4 v2 : COLOR0,
  float4 v3 : TEXCOORD2,
  float4 v4 : TEXCOORD3,
  float4 v5 : TEXCOORD4,
  float4 v6 : TEXCOORD5,
  float3 v7 : TEXCOORD6,
  float2 v8 : BLENDWEIGHT0,
  float4 pos : POSITION0,
  out float4 o0 : SV_Target0,
  out float4 o1 : SV_Target1,
  out float4 o2 : SV_Target2,
  out float4 o3 : SV_Target3,
  out float2 motionVectors : SV_Target4)
{

  float4 posCurr = mul(pos.xyzw, gWorldViewProjUnjittered);
  float4 posPrev = mul(pos.xyzw, gWorldViewProjUnjitteredPrev);
  posCurr.xy = posCurr.xy/posCurr.ww;
  posPrev.xy = posPrev.xy/posPrev.ww;
  motionVectors.xy = (posPrev.xy-posCurr.xy) * float2(0.5, -0.5);
  const float4 icb[] = { { 1.000000, 0, 0, 0},
                              { 0, 1.000000, 0, 0},
                              { 0, 0, 1.000000, 0},
                              { 0, 0, 0, 1.000000},
                              { 0, 0, 0, 0.800000},
                              { 0, 0, 0, 0.500000},
                              { 0, 0, 0, 0.100000},
                              { 0, 0, 0, 0} };
  float4 r0,r1,r2,r3,r4,r5,r6,r7,r8;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)v0.xy;
  r0.xy = (int2)r0.xy & int2(1,1);
  r0.y = (uint)r0.y << 1;
  r0.x = (int)r0.x + (int)r0.y;
  r0.x = dot(globalFade.xyzw, icb[r0.x+0].xyzw);
  r0.x = cmp(r0.x < 1);
  if (r0.x != 0) discard;
  r0.x = dot(v7.xyz, v7.xyz);
  r0.x = rsqrt(r0.x);
  r0.xyz = v7.xyz * r0.xxx;
  r0.w = dot(v3.xyz, v3.xyz);
  r0.w = rsqrt(r0.w);
  r1.xyz = v3.xyz * r0.www;
  r0.x = dot(r0.xyz, r1.xyz);
  r0.y = saturate(0.0500000007 * v1.z);
  r0.z = abs(r0.x) * -24 + 27;
  r0.w = cmp(r0.y != 1.000000);
  if (r0.w != 0) {
    r0.w = 5 * r0.y;
    r1.x = (int)r0.w;
    r1.x = min(4, (int)r1.x);
    r1.y = (int)r1.x + 1;
    r1.y = min(4, (int)r1.y);
    r0.w = trunc(r0.w);
    r0.w = r0.y * 5 + -r0.w;
    r1.y = icb[r1.y+3].w + -icb[r1.x+3].w;
    r0.w = r0.w * r1.y + icb[r1.x+3].w;
  } else {
    r0.w = 0;
  }
  r1.x = r0.z * r0.w;
  r1.y = (int)r1.x;
  r1.w = cmp(0 >= (int)r1.y);
  r2.x = cmp(POMFlags.x == 1.000000);
  r1.w = (int)r1.w | (int)r2.x;
  if (r1.w == 0) {
    r1.w = saturate(v8.x);
    r1.w = 1 + -r1.w;
    r2.x = -13 + v1.z;
    r2.x = saturate(0.142857149 * r2.x);
    r2.x = 1 + -r2.x;
    r1.w = r2.x * r1.w;
    r0.z = saturate(r0.z * r0.w + -1);
    r0.x = 4 * abs(r0.x);
    r0.x = min(1, r0.x);
    r0.x = r0.z * r0.x;
    r0.x = r1.w * r0.x;
    r0.x = globalHeightScale * r0.x;
    r0.z = cmp(0 < r0.x);
    if (r0.z != 0) {
      r2.xyz = float3(1,1,1) + -v2.xyz;
      r0.z = r2.x * r2.y;
      r0.w = r0.z * r2.z;
      r0.z = v2.z * r0.z;
      r1.w = v2.y * r2.x;
      r2.x = r1.w * r2.z;
      r1.w = v2.z * r1.w;
      r2.yz = heightScale1 * r0.zz;
      r2.yz = heightScale0 * r0.ww + r2.yz;
      r2.yz = heightScale2 * r2.xx + r2.yz;
      r2.yz = heightScale3 * r1.ww + r2.yz;
      r2.y = r2.y * r0.x;
      r2.w = cmp(r2.y != 0.000000);
      if (r2.w != 0) {
        r3.x = dot(v5.xyz, v7.xyz);
        r3.y = dot(v6.xyz, v7.xyz);
        r3.z = dot(v3.xyz, v7.xyz);
        r2.w = max(0.100000001, v8.y);
        r2.w = min(1, r2.w);
        r2.w = 1 + -r2.w;
        r4.x = dot(v5.xyz, gDirectionalLight.xyz);
        r4.y = dot(v6.xyz, gDirectionalLight.xyz);
        r4.z = dot(v3.xyz, gDirectionalLight.xyz);
        r3.w = dot(r4.xyz, r4.xyz);
        r3.w = rsqrt(r3.w);
        r4.xyz = r4.xyz * r3.www;
        r3.w = dot(v3.xyz, r4.xyz);
        r3.w = cmp(0 < r3.w);
        r1.x = trunc(r1.x);
        r1.x = 1 / r1.x;
        r4.w = dot(r3.xyz, r3.xyz);
        r4.w = rsqrt(r4.w);
        r3.xyz = r4.www * r3.xyz;
        r2.w = max(r3.z, r2.w);
        r5.xy = -r3.xy / r2.ww;
        r5.xy = r5.xy * r2.yy;
        r3.xy = r3.xy / r2.ww;
        r2.zw = r3.xy * r2.zz;
        r2.zw = r2.zw * r0.xx;
        r6.xyzw = heightMapSamplerLayer0.SampleLevel(heightMapSamplerLayer0_s, v1.xy, 0).xyzw;
        r7.xyzw = heightMapSamplerLayer1.SampleLevel(heightMapSamplerLayer1_s, v1.xy, 0).xyzw;
        r0.x = r7.x * r0.z;
        r0.x = r6.x * r0.w + r0.x;
        r6.xyzw = heightMapSamplerLayer2.SampleLevel(heightMapSamplerLayer2_s, v1.xy, 0).xyzw;
        r0.x = r6.x * r2.x + r0.x;
        r6.xyzw = heightMapSamplerLayer3.SampleLevel(heightMapSamplerLayer3_s, v1.xy, 0).xyzw;
        r0.x = r6.x * r1.w + r0.x;
        r0.x = 9.99999997e-07 + r0.x;
        r3.xy = r2.zw;
        r3.z = 1;
        r4.w = 1;
        r5.zw = r0.xx;
        r6.x = 0;
        while (true) {
          r6.y = cmp((int)r6.x >= (int)r1.y);
          if (r6.y != 0) break;
          r6.y = cmp(r5.z < r3.z);
          if (r6.y != 0) {
            r6.y = r3.z + -r1.x;
            r3.xy = r5.xy * r1.xx + r3.xy;
            r6.zw = v1.xy + r3.xy;
            r7.xyzw = heightMapSamplerLayer0.SampleLevel(heightMapSamplerLayer0_s, r6.zw, 0).xyzw;
            r8.xyzw = heightMapSamplerLayer1.SampleLevel(heightMapSamplerLayer1_s, r6.zw, 0).xyzw;
            r7.y = r8.x * r0.z;
            r7.x = r7.x * r0.w + r7.y;
            r8.xyzw = heightMapSamplerLayer2.SampleLevel(heightMapSamplerLayer2_s, r6.zw, 0).xyzw;
            r7.x = r8.x * r2.x + r7.x;
            r8.xyzw = heightMapSamplerLayer3.SampleLevel(heightMapSamplerLayer3_s, r6.zw, 0).xyzw;
            r6.z = r8.x * r1.w + r7.x;
            r4.w = r3.z;
            r5.w = r5.z;
            r3.z = r6.y;
            r5.z = r6.z;
          } else {
            r6.x = r1.y;
          }
          r6.x = (int)r6.x + 1;
        }
        r1.x = -r5.z + r3.z;
        r1.y = -r5.w + r4.w;
        r3.x = r1.y + -r1.x;
        r3.y = cmp(r3.x != 0.000000);
        r1.x = r4.w * r1.x;
        r1.x = r3.z * r1.y + -r1.x;
        r1.x = r1.x / r3.x;
        r1.x = 1 + -r1.x;
        r1.x = r3.y ? r1.x : 0;
        r3.xy = r5.xy * r1.xx + r2.zw;
        r1.x = cmp(0 < parallaxSelfShadowAmount);
        r1.x = r1.x ? r3.w : 0;
        if (r1.x != 0) {
          r1.xy = r4.xy / r4.zz;
          r1.xy = r1.xy * r2.yy;
          r2.yz = float2(0,0);
          while (true) {
            r2.w = cmp((int)r2.z >= 7);
            if (r2.w != 0) break;
            r2.w = (int)r2.z;
            r2.w = -r2.w * 0.142857149 + 1;
            r4.xy = r1.xy * r2.ww + v1.xy;
            r5.xyzw = heightMapSamplerLayer0.SampleLevel(heightMapSamplerLayer0_s, r4.xy, 0).xyzw;
            r6.xyzw = heightMapSamplerLayer1.SampleLevel(heightMapSamplerLayer1_s, r4.xy, 0).xyzw;
            r3.w = r6.x * r0.z;
            r3.w = r5.x * r0.w + r3.w;
            r5.xyzw = heightMapSamplerLayer2.SampleLevel(heightMapSamplerLayer2_s, r4.xy, 0).xyzw;
            r3.w = r5.x * r2.x + r3.w;
            r4.xyzw = heightMapSamplerLayer3.SampleLevel(heightMapSamplerLayer3_s, r4.xy, 0).xyzw;
            r3.w = r4.x * r1.w + r3.w;
            r3.w = r3.w + -r0.x;
            r2.w = r3.w + -r2.w;
            r2.z = (int)r2.z + 1;
            r3.w = (int)r2.z;
            r2.w = r3.w * r2.w;
            r2.y = max(r2.y, r2.w);
          }
          r0.x = min(1, r2.y);
          r3.z = -r0.x * parallaxSelfShadowAmount + 1;
        } else {
          r3.z = 1;
        }
      } else {
        r3.xyz = float3(0,0,1);
      }
      r0.x = -1;
    } else {
      r3.xyz = float3(0,0,1);
      r0.x = 0;
    }
    r0.xzw = r0.xxx ? r3.xyz : float3(0,0,1);
  } else {
    r0.xzw = float3(0,0,1);
  }
  r0.xz = v1.xy + r0.xz;
  r1.xyw = saturate(v2.xyz);
  r2.xyz = float3(1,1,1) + -r1.xyw;
  r1.x = r2.x * r2.y;
  r2.y = r1.x * r2.z;
  r1.y = r2.x * r1.y;
  r2.x = r1.y * r2.z;
  r1.xy = r1.xy * r1.ww;
  r3.xyzw = TextureSampler_layer0.Sample(TextureSampler_layer0_s, r0.xz).xyzw;
  r4.xyzw = TextureSampler_layer1.Sample(TextureSampler_layer1_s, r0.xz).xyzw;
  r4.xyz = r4.xyz * r1.xxx;
  r2.yzw = r3.xyz * r2.yyy + r4.xyz;
  r3.xyzw = TextureSampler_layer2.Sample(TextureSampler_layer2_s, r0.xz).xyzw;
  r2.xyz = r3.xyz * r2.xxx + r2.yzw;
  r3.xyzw = TextureSampler_layer3.Sample(TextureSampler_layer3_s, r0.xz).xyzw;
  r1.xyw = r3.xyz * r1.yyy + r2.xyz;
  r2.xyz = float3(1,1,1) + -v2.xyz;
  r2.y = r2.x * r2.y;
  r2.w = r2.y * r2.z;
  r2.xy = v2.yz * r2.xy;
  r2.z = r2.x * r2.z;
  r2.x = v2.z * r2.x;
  r3.xyzw = BumpSampler_layer0.Sample(BumpSampler_layer0_s, r0.xz).xyzw;
  r4.xyzw = BumpSampler_layer1.Sample(BumpSampler_layer1_s, r0.xz).xyzw;
  r3.zw = r4.xy * r2.yy;
  r3.xy = r3.xy * r2.ww + r3.zw;
  r4.xyzw = BumpSampler_layer2.Sample(BumpSampler_layer2_s, r0.xz).xyzw;
  r3.xy = r4.xy * r2.zz + r3.xy;
  r4.xyzw = BumpSampler_layer3.Sample(BumpSampler_layer3_s, r0.xz).xyzw;
  r3.xy = r4.xy * r2.xx + r3.xy;
  r3.xy = r3.xy * float2(2,2) + float2(-1,-1);
  r3.z = dot(r3.xy, r3.xy);
  r3.z = 1 + -r3.z;
  r3.z = sqrt(abs(r3.z));
  r3.w = max(0.00100000005, bumpiness);
  r3.xy = r3.xy * r3.ww;
  r4.xyz = v6.xyz * r3.yyy;
  r3.xyw = r3.xxx * v5.xyz + r4.xyz;
  r3.xyz = r3.zzz * v3.xyz + r3.xyw;
  r3.w = dot(r3.xyz, r3.xyz);
  r3.w = rsqrt(r3.w);
  r4.xyz = r3.xyz * r3.www;
  r3.x = materialWetnessMultiplier.y * r2.y;
  r3.x = materialWetnessMultiplier.x * r2.w + r3.x;
  r3.x = materialWetnessMultiplier.z * r2.z + r3.x;
  r3.x = materialWetnessMultiplier.w * r2.x + r3.x;
  r5.xyzw = heightMapSamplerLayer0.Sample(heightMapSamplerLayer0_s, r0.xz).xyzw;
  r6.xyzw = heightMapSamplerLayer1.Sample(heightMapSamplerLayer1_s, r0.xz).xyzw;
  r2.y = r6.y * r2.y;
  r2.y = r5.y * r2.w + r2.y;
  r5.xyzw = heightMapSamplerLayer2.Sample(heightMapSamplerLayer2_s, r0.xz).xyzw;
  r2.y = r5.y * r2.z + r2.y;
  r5.xyzw = heightMapSamplerLayer3.Sample(heightMapSamplerLayer3_s, r0.xz).xyzw;
  r0.x = r5.y * r2.x + r2.y;
  r0.x = r0.x * r0.x + -1;
  r0.z = specIntensityAdjust * r0.x + 1;
  r2.x = specularIntensityMultSpecMap * r0.z;
  r0.x = specFalloffAdjust * r0.x + 1;
  r0.x = specularFalloffMultSpecMap * r0.x;
  r0.z = cmp(r0.y == 1.000000);
  r2.z = dot(r1.xyw, float3(1.27499998,4.29239988,0.432599992));
  r2.z = 0.5 + -r2.z;
  r2.z = saturate(v3.w + -r2.z);
  r2.w = cmp(0.800000012 < r0.y);
  r0.y = -0.800000012 + r0.y;
  r0.y = 5 * r0.y;
  r3.y = r2.z + -r0.w;
  r0.y = r0.y * r3.y + r0.w;
  r0.y = r2.w ? r0.y : r0.w;
  o2.w = r0.z ? r2.z : r0.y;
  r0.y = saturate(r1.z * 128 + -127);
  o1.xyz = r4.xyz * float3(0.5,0.5,0.5) + float3(0.5,0.5,0.5);
  r0.z = -0.100000001 + r3.x;
  r0.z = saturate(10 * r0.z);
  o1.w = r0.y * r0.z;
  r2.y = 0.001953125 * r0.x;
  r0.x = gLightArtificialIntAmbient0.w + v4.x;
  r0.y = v4.y;
  r0.xy = float2(0.5,0.5) * r0.xy;
  o3.xy = sqrt(r0.xy);
  r0.x = r3.z * r3.w + -0.349999994;
  r0.x = saturate(1.53846157 * r0.x);
  r0.x = gDynamicBakesAndWetness.z * r0.x;
  r0.y = 1 + -globalScalars2.z;
  r0.x = r0.x * r0.y;
  r0.x = v4.x * r0.x;
  r0.y = -r2.x * 0.5 + 1;
  r0.y = r0.x * r0.y;
  r0.z = 1 + -r3.x;
  r0.y = r0.y * r0.z;
  r0.x = r0.x * r3.x;
  r0.y = r0.y * -0.5 + 1;
  o0.xyz = r1.xyw * r0.yyy;
  r0.yz = float2(0.5,0.48828125) + -r2.xy;
  r0.yz = max(float2(0,0), r0.yz);
  r0.xy = r0.yz * r0.xx + r2.xy;
  o2.xy = sqrt(r0.xy);
  o0.w = globalScalars.x;
  o2.z = 0.980000019;
  o3.zw = float2(0,1.00188386);
  return;
}