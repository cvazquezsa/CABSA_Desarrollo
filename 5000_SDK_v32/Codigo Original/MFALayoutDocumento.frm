
[Forma]
Clave=MFALayoutDocumento
Icono=0
CarpetaPrincipal=Lista
Modulos=(Todos)
Nombre=MFA - Captura Manual Documentos

ListaCarpetas=Lista
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialAlturaCliente=591
PosicionInicialAncho=1162
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEstadoInicial=Normal
PosicionInicialIzquierda=102
PosicionInicialArriba=49
Comentarios=Lista(Info.Ejercicio,Info.Periodo)
[Lista]
Estilo=Hoja
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MFALayoutDocumento
Fuente={Tahoma, 8, Negro, []}
HojaTitulos=S
HojaMostrarColumnas=S
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)

CarpetaVisible=S

Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
FiltroGeneral=PeriodoID = {Comillas(Info.Titulo)}
[Lista.MFALayoutDocumento.emisor]
Carpeta=Lista
Clave=MFALayoutDocumento.emisor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFALayoutDocumento.empresa]
Carpeta=Lista
Clave=MFALayoutDocumento.empresa
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco

[Lista.MFALayoutDocumento.fecha]
Carpeta=Lista
Clave=MFALayoutDocumento.fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco


[Lista.MFALayoutDocumento.entidad_clave]
Carpeta=Lista
Clave=MFALayoutDocumento.entidad_clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.MFAEntidad.entidad_nombre]
Carpeta=Lista
Clave=MFAEntidad.entidad_nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Lista.MFAEntidad.entidad_rfc]
Carpeta=Lista
Clave=MFAEntidad.entidad_rfc
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=15
ColorFondo=Blanco



[Lista.MFALayoutDocumento.agente_clave]
Carpeta=Lista
Clave=MFALayoutDocumento.agente_clave
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco

[Lista.Agente.Nombre]
Carpeta=Lista
Clave=Agente.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco

[Acciones.Aceptar]
Nombre=Aceptar
Boton=3
NombreEnBoton=S
NombreDesplegar=&Guardar y cerrar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Lista.Columnas]
emisor=47
empresa=45
fecha=60
origen_modulo=53
entidad_clave=68
entidad_nombre=141
entidad_rfc=94
entidad_pais=87
Nacionalidad=143
agente_clave=58
Nombre=95

0=90
1=299
2=-2






origen_id=115

folio=39
tipo_documento=82
entidad_nacionalidad=80
entidad_tipo_tercero=64
entidad_tipo_operacion=86
[Lista.MFALayoutDocumento.origen_id]
Carpeta=Lista
Clave=MFALayoutDocumento.origen_id
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Acciones.Detalle]
Nombre=Detalle
Boton=47
NombreEnBoton=S
NombreDesplegar=&Detalle
GuardarAntes=S
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=MFALayoutDocumentoD
Activo=S
Antes=S
Visible=S







DespuesGuardar=S
AntesExpresiones=Asigna(Info.MovID, MFALayoutDocumento:MFALayoutDocumento.folio)<BR>Asigna(Info.Categoria, SQL(<T>SELECT DocumentoID FROM MFALayoutDocumento WHERE RID = :nRID<T>, MFALayoutDocumento:MFALayoutDocumento.RID))
[Lista.MFALayoutDocumento.folio]
Carpeta=Lista
Clave=MFALayoutDocumento.folio
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco













[Lista.MFALayoutDocumento.tipo_documento]
Carpeta=Lista
Clave=MFALayoutDocumento.tipo_documento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco



















[Lista.MFAEntidad.entidad_pais]
Carpeta=Lista
Clave=MFAEntidad.entidad_pais
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco

[Lista.MFAEntidad.entidad_nacionalidad]
Carpeta=Lista
Clave=MFAEntidad.entidad_nacionalidad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco





[Lista.MFAEntidad.entidad_tipo_tercero]
Carpeta=Lista
Clave=MFAEntidad.entidad_tipo_tercero
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=10
ColorFondo=Blanco

[Lista.MFAEntidad.entidad_tipo_operacion]
Carpeta=Lista
Clave=MFAEntidad.entidad_tipo_operacion
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco








































[Lista.ListaEnCaptura]
(Inicio)=MFALayoutDocumento.origen_modulo
MFALayoutDocumento.origen_modulo=MFALayoutDocumento.origen_id
MFALayoutDocumento.origen_id=MFALayoutDocumento.emisor
MFALayoutDocumento.emisor=MFALayoutDocumento.empresa
MFALayoutDocumento.empresa=MFALayoutDocumento.tipo_documento
MFALayoutDocumento.tipo_documento=MFALayoutDocumento.folio
MFALayoutDocumento.folio=MFALayoutDocumento.fecha
MFALayoutDocumento.fecha=MFALayoutDocumento.entidad_clave
MFALayoutDocumento.entidad_clave=MFAEntidad.entidad_nombre
MFAEntidad.entidad_nombre=MFAEntidad.entidad_rfc
MFAEntidad.entidad_rfc=MFAEntidad.entidad_pais
MFAEntidad.entidad_pais=MFAEntidad.entidad_nacionalidad
MFAEntidad.entidad_nacionalidad=MFAEntidad.entidad_tipo_tercero
MFAEntidad.entidad_tipo_tercero=MFAEntidad.entidad_tipo_operacion
MFAEntidad.entidad_tipo_operacion=MFALayoutDocumento.agente_clave
MFALayoutDocumento.agente_clave=Agente.Nombre
Agente.Nombre=(Fin)

[Lista.MFALayoutDocumento.origen_modulo]
Carpeta=Lista
Clave=MFALayoutDocumento.origen_modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=5
ColorFondo=Blanco





























[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Detalle
Detalle=(Fin)
