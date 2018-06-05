[Forma]
Clave=MovCte
Nombre=Generar Movimiento
Icono=0
Modulos=(Todos)
ListaCarpetas=Lista
CarpetaPrincipal=Lista
PosicionInicialIzquierda=802
PosicionInicialArriba=420
PosicionInicialAlturaCliente=323
PosicionInicialAncho=324
VentanaTipoMarco=Normal
VentanaPosicionInicial=Centrado
VentanaEscCerrar=S
BarraHerramientas=S
AccionesTamanoBoton=15x5
AccionesDerecha=S
ListaAcciones=(Lista)
Comentarios=Info.Cliente
ExpresionesAlCerrar=Asigna(Filtro.Cliente, Nulo)<BR>Asigna(Filtro.Mov, Nulo)

[Lista]
Estilo=Hoja
Clave=Lista
Zona=A1
Vista=MovCte
Fuente={Tahoma, 8, Negro, []}
CampoColorLetras=Negro
CampoColorFondo=Blanco
CarpetaVisible=S
OtroOrden=S
ListaOrden=MovCte.Orden<TAB>(Acendente)
HojaMostrarRenglones=S
HojaColoresPorEstatus=S
HojaMantenerSeleccion=S
HojaPermiteInsertar=S
HojaPermiteEliminar=S
HojaVistaOmision=Automática
ListaEnCaptura=MovCte.Nombre

[Lista.Columnas]
0=363
Nombre=287

[Acciones.Generar]
Nombre=Generar
Boton=23
NombreEnBoton=S
NombreDesplegar=<T>&Generar<T>
EnBarraHerramientas=S
TipoAccion=Expresion
Activo=S
Visible=S
ConCondicion=S
Expresion=Caso MovCte:MovCte.Tipo<BR>  Es <T>Punto Venta<T>   <BR>    Entonces Si(ConDatos(MovCte:MovCte.Mov), PlugIn(<T>PV<T>, <T>VTAS<T>, MovCte:MovCte.Mov, Info.Cliente, Nulo, Falso))<BR><BR>  Es <T>Facturar Notas Consumo<T> <BR>    Entonces Forma(<T>FacturarVentaNO<T>)<BR><BR>  Es <T>Modulo<T>        <BR>    Entonces <BR>      Asigna(Filtro.Cliente, Info.Cliente) <BR>      Asigna(Filtro.Aseguradora, Info.Aseguradora)<BR>      Asigna(Filtro.Mov, MovCte:MovCte.Mov)<BR>      Caso MovCte:MovCte.Modulo<BR>        Es <T>VTAS<T> Entonces <BR>                    Asigna(Info.SubModuloVenta, Vacio(MovCte:MovCte.SubModulo, MovCte:MovCte.SubModulo)) <BR>                    Asigna(Info.ModuloVentasNombre, SQL(<T>SELECT Nombre FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSubModulo<T>, MovCte:MovCte.Modulo, Info.SubModuloVenta))<BR>                    Forma(<T>Venta<T>)<BR>        Es <T>ST<T>   Entonces <BR>                    Asigna(Info.SubModuloST, Vacio(MovCte:MovCte.SubModulo, MovCte:MovCte.SubModulo)) <BR>                    Asigna(Info.STNombre, SQL(<T>SELECT Nombre FROM SubModulo WHERE Modulo=:tModulo AND SubModulo=:tSubModulo<T>, MovCte:MovCte.Modulo, Info.SubModuloST))<BR>                    Forma(<T>Soporte<T>)<BR>        Es <T>CXC<T>  Entonces <BR>                    Forma(<T>Cxc<T>)<BR>      Fin<BR>Fin
EjecucionCondicion=ConDatos(MovCte:MovCte.Nombre) y ConDatos(MovCte:MovCte.Tipo)

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

[Lista.MovCte.Nombre]
Carpeta=Lista
Clave=MovCte.Nombre
Editar=S
LineaNueva=S
ValidaNombre=S
3D=S
Tamano=100
ColorFondo=Blanco
ColorFuente=Negro

[Forma.ListaAcciones]
(Inicio)=Generar
Generar=Cancelar
Cancelar=(Fin)
