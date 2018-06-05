[Forma]
Clave=MonInterbancario
Nombre=<T>Dolar Interbancario<T>
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialIzquierda=847
PosicionInicialArriba=536
PosicionInicialAltura=118
PosicionInicialAncho=225
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
PosicionInicialAlturaCliente=91

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=Mon
Fuente={Tahoma, 28, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Mon.Interbancario
CarpetaVisible=S
Filtros=S
ConFuenteEspecial=S
FiltroPredefinido=S
FiltroNullNombre=(sin clasificar)
FiltroEnOrden=S
FiltroTodoNombre=Todo
FiltroAncho=20
FiltroRespetar=S
FiltroTipo=General
PermiteEditar=S
FiltroGeneral=Moneda=<T>Dolar<T>

[Ficha.Mon.Interbancario]
Carpeta=Ficha
Clave=Mon.Interbancario
Editar=N
LineaNueva=S
ValidaNombre=N
3D=S
ColorFuente=Negro
Tamano=8
Efectos=[Negritas]
ColorFondo=Plata
IgnoraFlujo=N

[Acciones.Incrementar]
Nombre=Incrementar
Boton=62
EnBarraHerramientas=S
Activo=S
Visible=S
NombreDesplegar=Incrementar
Multiple=S
ListaAccionesMultiples=Expresion<BR>Guardar Cambios

[Acciones.Disminuir]
Nombre=Disminuir
Boton=63
NombreDesplegar=Disminuir
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
EspacioPrevio=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Guardar Cambios

[Acciones.Disminuir2]
Nombre=Disminuir2
Boton=63
NombreDesplegar=Disminuir
EnBarraHerramientas=S
EspacioPrevio=S
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Guardar Cambios

[Acciones.Incrementar2]
Nombre=Incrementar2
Boton=62
NombreDesplegar=Incrementar
EnBarraHerramientas=S
Activo=S
Visible=S
Multiple=S
ListaAccionesMultiples=Expresion<BR>Guardar Cambios

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S
NombreEnBoton=S

[Acciones.Disminuir.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Mon:Mon.Interbancario,  Redondea(Mon:Mon.Interbancario-0.001, 4))
Activo=S
Visible=S

[Acciones.Disminuir.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Incrementar.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=Asigna(Mon:Mon.Interbancario,  Redondea(Mon:Mon.Interbancario+0.001, 4))

[Acciones.Incrementar.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Disminuir2.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Mon:Mon.Interbancario,  Redondea(Mon:Mon.Interbancario-0.0001, 4))
Activo=S
Visible=S

[Acciones.Disminuir2.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Acciones.Incrementar2.Expresion]
Nombre=Expresion
Boton=0
TipoAccion=Expresion
Expresion=Asigna(Mon:Mon.Interbancario,  Redondea(Mon:Mon.Interbancario+0.0001, 4))
Activo=S
Visible=S

[Acciones.Incrementar2.Guardar Cambios]
Nombre=Guardar Cambios
Boton=0
TipoAccion=Controles Captura
ClaveAccion=Guardar Cambios
Activo=S
Visible=S

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Disminuir
Disminuir=Incrementar
Incrementar=Disminuir2
Disminuir2=Incrementar2
Incrementar2=(Fin)
