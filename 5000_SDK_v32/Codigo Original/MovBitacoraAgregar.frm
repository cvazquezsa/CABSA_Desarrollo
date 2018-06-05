[Forma]
Clave=MovBitacoraAgregar
Icono=0
Modulos=(Todos)
Nombre=<T>Agregar Evento<T>
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=668
PosicionInicialArriba=496
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
Comentarios=Info.Mov+<T> <T>+Info.MovID
PosicionInicialAlturaCliente=172
VentanaEstadoInicial=Normal

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=MovBitacora
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

[Ficha.MovBitacora.Evento]
Carpeta=Ficha
Clave=MovBitacora.Evento
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=70x5
ColorFondo=Blanco
ColorFuente=Negro
Efectos=[Negritas]

[Ficha.MovBitacora.Fecha]
Carpeta=Ficha
Clave=MovBitacora.Fecha
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

[Ficha.MovBitacora.Tipo]
Carpeta=Ficha
Clave=MovBitacora.Tipo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=25
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.MovBitacora.Duracion]
Carpeta=Ficha
Clave=MovBitacora.Duracion
Editar=S
LineaNueva=N
ValidaNombre=S
3D=S
Tamano=6
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Ficha.MovBitacora.DuracionUnidad]
Carpeta=Ficha
Clave=MovBitacora.DuracionUnidad
Editar=S
ValidaNombre=N
3D=S
Tamano=10
ColorFondo=Blanco
ColorFuente=Negro
Pegado=S

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=MovBitacora.Tipo
MovBitacora.Tipo=MovBitacora.Evento
MovBitacora.Evento=MovBitacora.Fecha
MovBitacora.Fecha=MovBitacora.Duracion
MovBitacora.Duracion=MovBitacora.DuracionUnidad
MovBitacora.DuracionUnidad=(Fin)
