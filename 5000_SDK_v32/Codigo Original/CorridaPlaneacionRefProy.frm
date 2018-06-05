[Forma]
Clave=CorridaPlaneacionRefProy
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=579
PosicionInicialArriba=387
PosicionInicialAlturaCliente=99
PosicionInicialAncho=281
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
TipoAccion=Expresion
Activo=S
Visible=S

Expresion=Asigna(Info.PlanReferenciaModulo, <T>PROY<T>)<BR>Asigna(Info.PlanReferencia, Info.PlanReferenciaProy)<BR>Dialogo(<T>CorridaPlaneacion<T>)
[Acciones.Generar.Aceptar]
Nombre=Aceptar
Boton=0
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S


[Lista.Columnas]
0=610
1=-2




2=56

[Lista.Info.PlanReferenciaProy]
Carpeta=Lista
Clave=Info.PlanReferenciaProy
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro








[Lista.Info.PlanReferenciaActividad]
Carpeta=Lista
Clave=Info.PlanReferenciaActividad
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro










[Lista.ListaEnCaptura]
(Inicio)=Info.PlanReferenciaProy
Info.PlanReferenciaProy=Info.PlanReferenciaActividad
Info.PlanReferenciaActividad=(Fin)


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
