[Forma]
Clave=VentaFechaEntrega
Nombre=Fecha Entrega
Icono=0
Modulos=(Todos)
ListaCarpetas=Ficha
CarpetaPrincipal=Ficha
PosicionInicialAlturaCliente=60
PosicionInicialAncho=245
EsConsultaExclusiva=S
SinCondicionDespliege=S
PosicionInicialIzquierda=517
PosicionInicialArriba=468
VentanaTipoMarco=Diálogo
VentanaPosicionInicial=Centrado
VentanaExclusiva=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Lista(Info.Mov, Info.MovID)

[Ficha]
Estilo=Ficha
Clave=Ficha
AlineacionAutomatica=S
AcomodarTexto=S
MostrarConteoRegistros=S
Zona=A1
Vista=VentaFechaEntrega
Fuente={Tahoma, 8, Negro, []}
FichaEspacioEntreLineas=6
FichaEspacioNombres=100
FichaEspacioNombresAuto=S
FichaNombres=Izquierda
FichaAlineacion=Izquierda
FichaColorFondo=Plata
FichaAlineacionDerecha=S
CampoColorLetras=Negro
CampoColorFondo=Plata
ListaEnCaptura=Venta.FechaEntrega
CarpetaVisible=S

[Ficha.Venta.FechaEntrega]
Carpeta=Ficha
Clave=Venta.FechaEntrega
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=20
ColorFondo=Plata
ColorFuente=Negro

[Acciones.Cerrar]
Nombre=Cerrar
Boton=23
NombreEnBoton=S
NombreDesplegar=&Cerrar
EnBarraHerramientas=S
TipoAccion=Ventana
ClaveAccion=Cerrar
Activo=S
Visible=S

[Acciones.Calcular]
Nombre=Calcular
Boton=92
NombreEnBoton=S
NombreDesplegar=&Calcular
EnBarraHerramientas=S
EspacioPrevio=S
TipoAccion=Expresion
Activo=S
Visible=S
Expresion=ProcesarSQL(<T>spSugerirVentaDAgenteFecha :nID<T>, Info.ID)<BR>Forma.ActualizarVista

[Forma.ListaAcciones]
(Inicio)=Cerrar
Cerrar=Calcular
Calcular=(Fin)
