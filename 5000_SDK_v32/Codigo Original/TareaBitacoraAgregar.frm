[Forma]
Clave=TareaBitacoraAgregar
Icono=0
Modulos=(Todos)
Nombre=<T>Agregar Evento<T>
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=348
PosicionInicialArriba=424
PosicionInicialAltura=175
PosicionInicialAncho=583
IniciarAgregando=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
Comentarios=Info.Descripcion
PosicionInicialAlturaCliente=148

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=TareaBitacora
Fuente={MS Sans Serif, 8, Negro, []}
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

[Ficha.TareaBitacora.Evento]
Carpeta=Ficha
Clave=TareaBitacora.Evento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70x5
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.TareaBitacora.Fecha]
Carpeta=Ficha
Clave=TareaBitacora.Fecha
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S

[Acciones.Cancelar.Cancelar]
Nombre=Cancelar
Boton=0
TipoAccion=Ventana
ClaveAccion=Cancelar
Activo=S
Visible=S

[Acciones.Cancelar.Cambios]
Nombre=Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Cancelar Cambios
Activo=S
Visible=S

[Acciones.Cancelar]
Nombre=Cancelar
Boton=36
NombreEnBoton=S
NombreDesplegar=<T>&Cancelar<T>
Multiple=S
EnBarraHerramientas=S
TipoAccion=Ventana
ListaAccionesMultiples=Cambios<BR>Cancelar
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=TareaBitacora.Evento
TareaBitacora.Evento=TareaBitacora.Fecha
TareaBitacora.Fecha=(Fin)
