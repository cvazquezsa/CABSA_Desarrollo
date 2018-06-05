[Forma]
Clave=CorridaPlaneacion
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=843
PosicionInicialArriba=466
PosicionInicialAlturaCliente=232
PosicionInicialAncho=233
Nombre=<T>Especificar Corrida<T>
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)

[Lista]
Estilo=Ficha
Clave=Lista
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=(Variables)
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Blanco
ListaEnCaptura=(Lista)
CarpetaVisible=S

[Lista.Info.ArtCat]
Carpeta=Lista
Clave=Info.ArtCat
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=N

[Lista.Info.ArtGrupo]
Carpeta=Lista
Clave=Info.ArtGrupo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Info.ArtFam]
Carpeta=Lista
Clave=Info.ArtFam
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Info.Proveedor]
Carpeta=Lista
Clave=Info.Proveedor
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro
EspacioPrevio=S

[Lista.Info.Fabricante]
Carpeta=Lista
Clave=Info.Fabricante
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Generar]
Nombre=Generar
Boton=92
NombreEnBoton=S
NombreDesplegar=&Generar
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=(Lista)

[Lista.Info.ArtLinea]
Carpeta=Lista
Clave=Info.ArtLinea
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Lista.Info.ArtTemporada]
Carpeta=Lista
Clave=Info.ArtTemporada
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Generar.Variables Asignar]
Nombre=Variables Asignar
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Variables Asignar
Activo=S
Visible=S

[Acciones.Bitacora]
Nombre=Bitacora
Boton=56
NombreEnBoton=S
NombreDesplegar=&Bitácora
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Formas
ClaveAccion=PlanBitacora
Activo=S
Visible=S

[Acciones.Generar.CorridaPlaneacion]
Nombre=CorridaPlaneacion
Boton=0
TipoAccion=Dialogos
ClaveAccion=CorridaPlaneacion
Activo=S
Visible=S

[Acciones.Generar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Lista.ListaEnCaptura]
(Inicio)=Info.ArtCat
Info.ArtCat=Info.ArtGrupo
Info.ArtGrupo=Info.ArtFam
Info.ArtFam=Info.Fabricante
Info.Fabricante=Info.ArtLinea
Info.ArtLinea=Info.ArtTemporada
Info.ArtTemporada=Info.Proveedor
Info.Proveedor=(Fin)




[Acciones.Generar.ListaAccionesMultiples]
(Inicio)=Variables Asignar
Variables Asignar=CorridaPlaneacion
CorridaPlaneacion=Aceptar
Aceptar=(Fin)

[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=Bitacora
Bitacora=(Fin)
