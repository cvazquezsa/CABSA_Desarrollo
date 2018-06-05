[Forma]
Clave=SoporteAnexo
Nombre=Anexo
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
PosicionInicialIzquierda=747
PosicionInicialArriba=437
PosicionInicialAlturaCliente=298
PosicionInicialAncho=426
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaExclusiva=S

[Ficha]
Estilo=Ficha
Clave=Ficha
PermiteEditar=S
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=SoporteAnexo
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
Filtros=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=(Todo)
FiltroAncho=20
FiltroGeneral=SoporteAnexo.Modulo=<T>{Anexo.Modulo}<T> AND SoporteAnexo.ID={Anexo.ID}
FiltroRespetar=S
FiltroTipo=General

[Ficha.SoporteAnexo.Modulo]
Carpeta=Ficha
Clave=SoporteAnexo.Modulo
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Blanco
ColorFuente=Negro

[Ficha.SoporteAnexo.ID]
Carpeta=Ficha
Clave=SoporteAnexo.ID
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
ColorFondo=Blanco
ColorFuente=Negro
Tamano=20

[Ficha.SoporteAnexo.Nombre]
Carpeta=Ficha
Clave=SoporteAnexo.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=50
ColorFondo=Blanco
ColorFuente=Negro

[Acciones.Aceptar]
Nombre=Aceptar
Boton=23
NombreDesplegar=&Aceptar
GuardarAntes=S
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Aceptar
Activo=S
Visible=S
NombreEnBoton=S

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

[Forma.ListaAcciones]
(Inicio)=Aceptar
Aceptar=Cancelar
Cancelar=(Fin)

[Ficha.ListaEnCaptura]
(Inicio)=SoporteAnexo.Modulo
SoporteAnexo.Modulo=SoporteAnexo.ID
SoporteAnexo.ID=SoporteAnexo.Nombre
SoporteAnexo.Nombre=(Fin)
